{*+**********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.1
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ************************************************************************************}
{strip}

<style>
    @import url('https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600&family=DM+Mono:wght@400;500&display=swap');

    /* ── Reset & base ── */
    .ml-wrap {
        font-family: 'DM Sans', sans-serif;
        background: #f8f9fb;
        display: flex;
        flex-direction: column;
        height: 100%;
    }

    /* ── Toolbar ── */
    .ml-toolbar {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 8px 14px;
        background: #ffffff;
        border-bottom: 1px solid #e8eaed;
        gap: 8px;
        flex-shrink: 0;
    }

    .ml-toolbar-left {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    /* Checkbox */
    .ml-toolbar input[type="checkbox"],
    .mailCheckBox {
        width: 15px;
        height: 15px;
        accent-color: #4f6ef7;
        cursor: pointer;
    }

    /* Icon action buttons */
    .ml-icon-btn {
        width: 30px;
        height: 30px;
        border: none;
        background: transparent;
        border-radius: 6px;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        color: #6b7280;
        font-size: 14px;
        transition: background 0.15s, color 0.15s;
        text-decoration: none;
        vertical-align: middle;
    }
    .ml-icon-btn:hover { background: #f1f3f4; color: #1a1d23; }
    .ml-icon-btn.ml-delete:hover { background: #fef2f2; color: #ef4444; }

    /* Move-to dropdown wrapper */
    .ml-move-dropdown { position: relative; display: inline-flex; }
    .ml-move-dropdown .dropdown-menu {
        min-width: 180px;
        border-radius: 8px;
        border: 1px solid #e5e7eb;
        box-shadow: 0 4px 16px rgba(0,0,0,0.10);
        padding: 4px 0;
        font-size: 13px;
    }
    .ml-move-dropdown .dropdown-menu li { list-style: none; }
    .ml-move-dropdown .dropdown-menu li a {
        display: block;
        padding: 7px 16px;
        color: #374151;
        cursor: pointer;
        transition: background 0.12s;
    }
    .ml-move-dropdown .dropdown-menu li a:hover { background: #f3f4f6; }

    /* Pagination info + buttons */
    .ml-toolbar-right {
        display: flex;
        align-items: center;
        gap: 6px;
        margin-left: auto;
    }

    .ml-page-info {
        font-size: 12px;
        color: #8a94a6;
        font-family: 'DM Mono', monospace;
        white-space: nowrap;
    }

    .ml-pager-btn {
        width: 28px;
        height: 28px;
        border: 1px solid #dadce0;
        background: #fff;
        border-radius: 6px;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        color: #5f6368;
        font-size: 13px;
        transition: background 0.15s;
    }
    .ml-pager-btn:hover:not([disabled]) { background: #f1f3f4; }
    .ml-pager-btn[disabled] { opacity: 0.4; cursor: default; }

    /* ── Search bar ── */
    .ml-search-bar {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 8px 14px;
        background: #ffffff;
        border-bottom: 1px solid #e8eaed;
        flex-shrink: 0;
    }

    .ml-search-input-wrap {
        position: relative;
        flex: 1;
    }

    .ml-search-input-wrap .ml-search-icon {
        position: absolute;
        left: 10px;
        top: 50%;
        transform: translateY(-50%);
        color: #9ca3af;
        font-size: 13px;
        pointer-events: none;
    }

    #mailManagerSearchbox {
        width: 100%;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        padding: 7px 12px 7px 32px;
        font-size: 13px;
        font-family: 'DM Sans', sans-serif;
        color: #374151;
        background: #f8f9fb;
        outline: none;
        transition: border-color 0.15s, box-shadow 0.15s;
        box-sizing: border-box;
    }
    #mailManagerSearchbox:focus {
        border-color: #4f6ef7;
        box-shadow: 0 0 0 3px rgba(79,110,247,0.10);
        background: #fff;
    }

    #searchType {
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        padding: 7px 10px;
        font-size: 13px;
        font-family: 'DM Sans', sans-serif;
        color: #374151;
        background: #f8f9fb;
        outline: none;
        cursor: pointer;
        height: 34px;
    }

    #mm_searchButton {
        border: none;
        background: #4f6ef7;
        color: #fff;
        border-radius: 8px;
        padding: 7px 16px;
        font-size: 13px;
        font-family: 'DM Sans', sans-serif;
        font-weight: 500;
        cursor: pointer;
        transition: background 0.15s;
        white-space: nowrap;
        height: 34px;
    }
    #mm_searchButton:hover { background: #3b5be0; }

    /* ── Mail list ── */
    #emailListDiv {
        flex: 1;
        overflow-y: auto;
        padding: 0;
        background: #fff;
    }

    .ml-entry {
        display: flex;
        align-items: flex-start;
        gap: 10px;
        padding: 11px 14px 11px 16px;
        border-bottom: 1px solid #f0f2f5;
        cursor: pointer;
        transition: background 0.12s;
        position: relative;
        background: #fff;
    }
    .ml-entry:hover { background: #f5f7ff; }
    .ml-entry.mmReadEmail { background: #fafbfc; }
    .ml-entry.mmReadEmail:hover { background: #f0f2fb; }

    /* Unread blue left bar */
    .ml-entry:not(.mmReadEmail)::before {
        content: '';
        position: absolute;
        left: 0; top: 0; bottom: 0;
        width: 3px;
        background: #4f6ef7;
    }

    /* Highlighted / selected */
    .ml-entry.highLightMail { background: #4f6ef7 !important; }
    .ml-entry.highLightMail .ml-sender,
    .ml-entry.highLightMail .ml-subject,
    .ml-entry.highLightMail .ml-date,
    .ml-entry.highLightMail .ml-paperclip { color: #fff !important; }
    .ml-entry.highLightMail .ml-avatar { background: rgba(255,255,255,0.25) !important; }

    /* Checkbox */
    .mailCheckBox { margin-top: 10px; flex-shrink: 0; }

    /* Avatar */
    .ml-avatar {
        width: 38px; height: 38px;
        border-radius: 50%;
        background: linear-gradient(135deg, #4f6ef7 0%, #7c3aed 100%);
        display: flex; align-items: center; justify-content: center;
        color: #fff; font-size: 15px; font-weight: 600;
        flex-shrink: 0; margin-top: 1px;
    }
    .ml-entry.mmReadEmail .ml-avatar {
        background: linear-gradient(135deg, #d1d5db 0%, #9ca3af 100%);
    }

    /* Body */
    .ml-entry-body { flex: 1; min-width: 0; }

    /* Row 1: sender + date */
    .ml-row1 {
        display: flex; align-items: center; gap: 6px; margin-bottom: 3px;
    }
    .ml-sender {
        flex: 1;
        font-size: 13.5px; font-weight: 700;
        color: #111827;
        white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
    }
    .ml-entry.mmReadEmail .ml-sender { font-weight: 500; color: #6b7280; }

    .ml-date {
        font-size: 11px; color: #9ca3af;
        white-space: nowrap;
        font-family: 'DM Mono', monospace; flex-shrink: 0;
    }

    /* Row 2: subject */
    .ml-subject {
        font-size: 12.5px; font-weight: 500;
        color: #374151;
        white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
    }
    .ml-entry.mmReadEmail .ml-subject { font-weight: 400; color: #9ca3af; }

    /* Paperclip */
    .ml-entry-meta { display: flex; align-items: flex-start; padding-top: 2px; flex-shrink: 0; }
    .ml-paperclip { color: #9ca3af; font-size: 12px; }

    /* No mails */
    .ml-empty {
        display: flex; flex-direction: column;
        align-items: center; justify-content: center;
        padding: 60px 20px; color: #9ca3af; font-size: 14px; gap: 10px;
        background: #fff;
    }
    .ml-empty i { font-size: 36px; color: #d1d5db; }
</style>

<div class="ml-wrap">

    {* ── Toolbar ── *}
    <div class="ml-toolbar">
        <div class="ml-toolbar-left">
            <input type='checkbox' id='mainCheckBox'>

            <span class="ml-icon-btn mmActionIcon" id="mmMarkAsRead" data-folder="{$FOLDER->name()}" title="{vtranslate('LBL_MARK_AS_READ', $MODULE)}">
                <img src="layouts/v7/skins/images/envelope-open.png" style="width:14px;height:auto;">
            </span>
            <span class="ml-icon-btn mmActionIcon" id="mmMarkAsUnread" data-folder="{$FOLDER->name()}" title="{vtranslate('LBL_Mark_As_Unread', $MODULE)}">
                <i class="fa fa-envelope"></i>
            </span>
            <span class="ml-icon-btn ml-delete mmActionIcon" id="mmDeleteMail" data-folder="{$FOLDER->name()}" title="{vtranslate('LBL_Delete', $MODULE)}">
                <i class="fa fa-trash-o"></i>
            </span>

            <span class="ml-move-dropdown moveToFolderDropDown more dropdown action" title="{vtranslate('LBL_MOVE_TO', $MODULE)}">
                <span class="ml-icon-btn dropdown-toggle" data-toggle="dropdown" style="width:auto; padding:0 8px; gap:4px;">
                    <i class="fa fa-folder" style="font-size:12px;"></i>
                    <i class="fa fa-arrow-right" style="font-size:10px;"></i>
                    <i class="fa fa-caret-down" style="font-size:10px;"></i>
                </span>
                <ul class="dropdown-menu" id="mmMoveToFolder">
                    {foreach item=folder from=$FOLDERLIST}
                        <li data-folder="{$FOLDER->name()}" data-movefolder='{$folder}'>
                            <a class="paddingLeft15">
                                {if mb_strlen($folder,'UTF-8')>25}
                                    {mb_substr($folder,0,25,'UTF-8')}…
                                {else}
                                    {$folder}
                                {/if}
                            </a>
                        </li>
                    {/foreach}
                </ul>
            </span>
        </div>

        <div class="ml-toolbar-right">
            {if $FOLDER->mails()}
                <span class="ml-page-info">
                    <span class="pageInfo">{$FOLDER->pageInfo()}</span>
                    <span class="pageInfoData"
                          data-start="{$FOLDER->getStartCount()}"
                          data-end="{$FOLDER->getEndCount()}"
                          data-total="{$FOLDER->count()}"
                          data-label-of="{vtranslate('LBL_OF')}"></span>
                </span>
            {/if}
            <button type="button" id="PreviousPageButton" class="ml-pager-btn"
                {if $FOLDER->hasPrevPage()}data-folder='{$FOLDER->name()}' data-page='{$FOLDER->pageCurrent(-1)}'{else}disabled="disabled"{/if}>
                <i class="fa fa-caret-left"></i>
            </button>
            <button type="button" id="NextPageButton" class="ml-pager-btn"
                {if $FOLDER->hasNextPage()}data-folder='{$FOLDER->name()}' data-page='{$FOLDER->pageCurrent(1)}'{else}disabled="disabled"{/if}>
                <i class="fa fa-caret-right"></i>
            </button>
        </div>
    </div>

    {* ── Search bar ── *}
    <div class="ml-search-bar">
        <div class="ml-search-input-wrap">
            <i class="fa fa-search ml-search-icon"></i>
            <input type="text" id="mailManagerSearchbox"
                   value="{$QUERY}"
                   data-foldername='{$FOLDER->name()}'
                   placeholder="{vtranslate('LBL_TYPE_TO_SEARCH', $MODULE)}">
        </div>
        <select id="searchType">
            {foreach item=arr key=option from=$SEARCHOPTIONS}
                <option value="{$arr}" {if $arr eq $TYPE}selected{/if}>{vtranslate($option, $MODULE)}</option>
            {/foreach}
        </select>
        <button id='mm_searchButton'>{vtranslate('LBL_Search', $MODULE)}</button>
    </div>

    {* ── Mail list ── *}
    {if $FOLDER->mails()}
        <div id='emailListDiv'>
            {assign var=IS_SENT_FOLDER value=$FOLDER->isSentFolder()}
            <input type="hidden" name="folderMailIds" value="{','|implode:$FOLDER->mailIds()}"/>

            {foreach item=MAIL from=$FOLDER->mails()}
                {if $MAIL->isRead()}
                    {assign var=IS_READ value=1}
                {else}
                    {assign var=IS_READ value=0}
                {/if}

                {assign var=DISPLAY_NAME value=$MAIL->from(40)}
                {assign var=FIRST_LETTER value=strtoupper(substr(strip_tags($DISPLAY_NAME), 0, 1))}

                <div class="ml-entry mailEntry {if $IS_READ}mmReadEmail{/if}"
                     id='mmMailEntry_{$MAIL->msgNo()}'
                     data-folder="{$FOLDER->name()}"
                     data-read='{$IS_READ}'>

                    <input type='checkbox' class='mailCheckBox'>
                    <div class="ml-avatar">{$FIRST_LETTER}</div>
                    <div class="ml-entry-body mmfolderMails">
                        {* msgNo and mm_foldername MUST be inside mmfolderMails — JS does emailElement.find('.msgNo') *}
                        <input type="hidden" class="msgNo" value='{$MAIL->msgNo()}'>
                        <input type="hidden" class='mm_foldername' value='{$FOLDER->name()}'>

                        {* nameSubjectHolder: JS reads/writes innerHTML for bold read/unread toggling *}
                        <div class="nameSubjectHolder">
                            {assign var=SUBJECT value=$MAIL->subject()}

                            {* Row 1: sender name + date *}
                            <div class="ml-row1">
                                <span class="ml-sender">{strip_tags($DISPLAY_NAME)}</span>
                                <span class="ml-date mmDateTimeValue"
                                      title="{Vtiger_Util_Helper::formatDateTimeIntoDayString(date('Y-m-d H:i:s', strtotime($MAIL->_date)))}">
                                    {Vtiger_Util_Helper::formatDateDiffInStrings(date('Y-m-d H:i:s', strtotime($MAIL->_date)))}
                                </span>
                            </div>

                            {* Row 2: subject *}
                            <div class="ml-subject">{strip_tags($SUBJECT)}</div>
                        </div>

                        {* mmMailDesc: JS injects body preview here via loadMailContents() *}
                        <div class="mmMailDesc" style="display:none;">
                            <img src="{vimage_path('128-dithered-regular.gif')}">
                        </div>
                    </div>

                    <div class="ml-entry-meta">
                        {assign var=ATTACHMENT value=$MAIL->attachments()}
                        {assign var=INLINE_ATTCH value=$MAIL->inlineAttachments()}
                        {assign var=ATTCHMENT_COUNT value=(php7_count($ATTACHMENT) - php7_count($INLINE_ATTCH))}
                        {if $ATTCHMENT_COUNT}
                            <i class="fa fa-paperclip ml-paperclip" title="{$ATTCHMENT_COUNT} attachment(s)"></i>
                        {/if}
                    </div>

                </div>
            {/foreach}
        </div>

    {else}
        <div class="ml-empty">
            <i class="fa fa-inbox"></i>
            <strong>{vtranslate('LBL_No_Mails_Found', $MODULE)}</strong>
        </div>
    {/if}

</div>{* /ml-wrap *}

{/strip}
