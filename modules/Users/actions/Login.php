<?php
/*+**********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.1
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ************************************************************************************/

/*require_once 'libraries/2FA/vendor/autoload.php';*/
require_once 'vendor/autoload.php';

class Users_Login_Action extends Vtiger_Action_Controller {

	function loginRequired() {
		return false;
	}

	function checkPermission(Vtiger_Request $request) {
		return true;
	} 

	function process(Vtiger_Request $request) {
		global $site_URL;
		if ($_SERVER["REQUEST_METHOD"] != "POST") {
                        echo "Invalid request";
                        exit();
                }

		$username = $request->get('username');
		$password = $request->getRaw('password');

		$user = CRMEntity::getInstance('Users');
		$user->column_fields['user_name'] = $username;

		if ($user->doLogin($password)) {

			$db = PearDatabase::getInstance();

            // Check if 2 Factor Authentication is On
            $result = $db->pquery("SELECT secret_key,is_use_two_factor_auth FROM vtiger_users WHERE user_name=?",array($username));

            $is_use_two_factor_auth = $db->query_result_rowdata($result,0)['is_use_two_factor_auth'];

            $secretKey = $db->query_result_rowdata($result,0)['secret_key'];

            if($is_use_two_factor_auth){

                if(!$secretKey || $secretKey == '') {
                    $google2fa = new PragmaRX\Google2FA\Google2FA();
                    $secret = $google2fa->generateSecretKey();
                    $host = parse_url($site_URL)['host'];
                    $qrCodeUrl = $google2fa->getQRCodeUrl($host, $username, $secret);
                    $qr_image = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=" . urlencode($qrCodeUrl);

                    echo json_encode(['status' => 'success', 'is_use_two_factor_auth' => true, 'qr_image' => $qr_image, 'secret' => $secret]);
                    exit;
                } else {
                    echo json_encode(['status' => 'success', 'is_use_two_factor_auth' => true]);
                }

            } else {

			session_regenerate_id(true); // to overcome session id reuse.

			$userid = $user->retrieve_user_id($username);
			Vtiger_Session::set('AUTHUSERID', $userid);

			// For Backward compatability
			// TODO Remove when switch-to-old look is not needed
			$_SESSION['authenticated_user_id'] = $userid;
			$_SESSION['app_unique_key'] = vglobal('application_unique_key');
			$_SESSION['authenticated_user_language'] = vglobal('default_language');
			$_SESSION['authenticated_user_skin'] = $request->get('skin');

			//Enabled session variable for KCFINDER 
			$_SESSION['KCFINDER'] = array(); 
			$_SESSION['KCFINDER']['disabled'] = false; 
			$_SESSION['KCFINDER']['uploadURL'] = "test/upload"; 
			$_SESSION['KCFINDER']['uploadDir'] = "../test/upload";
			$deniedExts = implode(" ", vglobal('upload_badext'));
			$_SESSION['KCFINDER']['deniedExts'] = $deniedExts;
			// End

			//Track the login History
			$moduleModel = Users_Module_Model::getInstance('Users');
			$moduleModel->saveLoginHistory($user->column_fields['user_name']);
			//End
						
			if(isset($_SESSION['return_params'])){
				$return_params = $_SESSION['return_params'];
			}

			echo json_encode(['status' => 'success', 'url' => 'index.php?module=Users&parent=Settings&view=SystemSetup']);

			//header ('Location: index.php?module=Users&parent=Settings&view=SystemSetup');
			//exit();
			}
		} else {
			echo json_encode(['status' => 'fail', 'url' => 'index.php?module=Users&parent=Settings&view=Login&error=login']);
			//header ('Location: index.php?module=Users&parent=Settings&view=Login&error=login');
			//exit;
		}
		exit;
	}

}
