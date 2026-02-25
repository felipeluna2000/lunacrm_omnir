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
    /* ── Google Fonts ── */
    @import url('https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600&family=DM+Mono:wght@400;500&display=swap');

    .mm-wrap {
        font-family: 'DM Sans', sans-serif;
        background: #ffffff;
        min-height: 100%;
        padding: 0;
    }

    /* ── Top action bar ── */
    .mm-topbar {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 8px 16px;
        background: #ffffff;
        border-bottom: 1px solid #e8eaed;
        position: sticky;
        top: 0;
        z-index: 10;
        min-height: 46px;
        gap: 10px;
    }

    /* Relation block — left side, grows to fill space */
    .mm-topbar .mm-relation {
        flex: 1;
        min-width: 0;
        display: flex;
        align-items: center;
    }

    /* When empty (before JS populates) keep it from collapsing */
    .mm-topbar .mm-relation:empty::after {
        content: '';
        display: block;
        height: 32px;
    }

    /* Pagination — right side, never shrinks */
    .mm-topbar .mm-pagination {
        display: flex;
        gap: 4px;
        flex-shrink: 0;
        margin-left: auto;
    }

    .mm-topbar .mm-pagination .btn {
        width: 28px;
        height: 28px;
        padding: 0;
        border-radius: 6px;
        border: 1px solid #dadce0;
        background: #fff;
        color: #5f6368;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 13px;
        transition: background 0.15s;
        line-height: 1;
    }
    .mm-topbar .mm-pagination .btn:hover:not([disabled]) { background: #f1f3f4; }
    .mm-topbar .mm-pagination .btn[disabled] { opacity: 0.4; cursor: default; }

    /* ── Mail card ── */
    .mm-card {
        background: #ffffff;
        border-radius: 0;
        box-shadow: none;
        margin: 0;
        border-top: 1px solid #f0f2f5;
    }

    /* ── Subject header ── */
    .mm-subject-bar {
        padding: 18px 20px 14px;
        border-bottom: 1px solid #f0f2f5;
    }

    .mm-subject-bar h4 {
        margin: 0;
        font-size: 17px;
        font-weight: 700;
        color: #111827;
        line-height: 1.4;
        letter-spacing: -0.2px;
    }

    /* ── Sender row ── */
    .mm-sender-row {
        display: flex;
        align-items: flex-start;
        gap: 12px;
        padding: 14px 20px;
        border-bottom: 1px solid #f0f2f5;
    }

    /* Avatar */
    .mm-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: linear-gradient(135deg, #4f6ef7 0%, #7c3aed 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-size: 16px;
        font-weight: 700;
        flex-shrink: 0;
        margin-top: 2px;
    }

    /* Meta block */
    .mm-meta-block {
        flex: 1;
        min-width: 0;
    }

    .mm-sender-name {
        font-size: 14px;
        font-weight: 700;
        color: #111827;
        margin: 0 0 5px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    /* ── Inline metadata grid ── */
    .mm-fields {
        display: grid;
        grid-template-columns: auto 1fr;
        gap: 2px 10px;
        font-size: 12px;
    }

    .mm-field-label {
        color: #9ca3af;
        font-weight: 600;
        font-size: 10.5px;
        text-transform: uppercase;
        letter-spacing: 0.6px;
        white-space: nowrap;
        padding-top: 3px;
        line-height: 1.6;
    }

    .mm-field-value {
        color: #4b5563;
        line-height: 1.6;
        word-break: break-word;
        font-size: 12.5px;
    }

    .mm-field-value a {
        color: #4f6ef7;
        text-decoration: none;
    }
    .mm-field-value a:hover { text-decoration: underline; }

    /* ── Date + action icons ── */
    .mm-date-actions {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        gap: 8px;
        flex-shrink: 0;
    }

    .mm-date {
        font-size: 11.5px;
        color: #9ca3af;
        white-space: nowrap;
        font-family: 'DM Mono', monospace;
        line-height: 1.4;
    }

    .mm-actions {
        display: flex;
        align-items: center;
        gap: 1px;
        background: #f8f9fb;
        border: 1px solid #e8eaed;
        border-radius: 8px;
        padding: 2px;
    }

    .mm-action-btn {
        width: 30px;
        height: 30px;
        border: none;
        background: transparent;
        border-radius: 6px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #6b7280;
        font-size: 13px;
        transition: background 0.13s, color 0.13s;
        text-decoration: none;
    }
    .mm-action-btn:hover {
        background: #ffffff;
        color: #1a1d23;
        box-shadow: 0 1px 3px rgba(0,0,0,0.08);
    }
    .mm-action-btn.mm-delete { margin-left: 2px; border-left: 1px solid #e8eaed; border-radius: 0 6px 6px 0; padding-left: 3px; }
    .mm-action-btn.mm-delete:hover { background: #fef2f2; color: #ef4444; box-shadow: none; }

    /* ── Attachment chip inline ── */
    .mm-attach-icon {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        background: #f0f2f5;
        border-radius: 4px;
        padding: 1px 7px;
        font-size: 11px;
        color: #5f6368;
        font-weight: 500;
    }

    /* ── Body area ── */
    .mm-body-area {
        padding: 20px;
        font-size: 14px;
        color: #2d3748;
        line-height: 1.7;
    }

    .mm-body-area #mmBody {
        max-width: 100%;
        overflow-x: auto;
    }

    /* ── Attachments section ── */
    .mm-attachments {
        padding: 14px 20px 18px;
        border-top: 1px solid #f0f2f5;
        background: #fafbfc;
    }

    .mm-attachments-title {
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.7px;
        color: #9ca3af;
        margin-bottom: 10px;
    }

    .mm-attach-list {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }

    .mm-attach-item {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        padding: 7px 12px;
        font-size: 12.5px;
        color: #374151;
        text-decoration: none;
        transition: border-color 0.15s, box-shadow 0.15s;
    }
    .mm-attach-item:hover {
        border-color: #4f6ef7;
        box-shadow: 0 0 0 3px rgba(79,110,247,0.08);
        text-decoration: none;
        color: #374151;
    }
    .mm-attach-item i { color: #6b7280; font-size: 15px; }
    .mm-attach-item .mm-attach-size { color: #9ca3af; font-size: 11px; }
    .mm-attach-dl { color: #4f6ef7; }
</style>

<div class="mm-wrap">

    {* Hidden inputs — unchanged *}
    <input type="hidden" id="mmFrom"            value='{implode(',', $MAIL->from())}'>
    <input type="hidden" id="mmSubject"         value='{Vtiger_Functions::jsonEncode($MAIL->subject())}'>
    <input type="hidden" id="mmMsgNo"           value="{$MAIL->msgNo()}">
    <input type="hidden" id="mmMsgUid"          value="{$MAIL->uniqueid()}">
    <input type="hidden" id="mmFolder"          value="{$FOLDER->name()}">
    <input type="hidden" id="mmTo"              value='{implode(',', $MAIL->to())}'>
    <input type="hidden" id="mmCc"              value="{if is_array($MAIL->cc())}{implode(',', $MAIL->cc())}{else}{$MAIL->cc()|escape:'html'}{/if}">
    <input type="hidden" id="mmDate"            value="{$MAIL->date()}">
    <input type="hidden" id="mmUserName"        value="{$USERNAME}">
    {assign var=ATTACHMENT_COUNT value=(php7_count($ATTACHMENTS) - php7_count($INLINE_ATT))}
    <input type="hidden" id="mmAttchmentCount"  value="{$ATTACHMENT_COUNT}">

    {* ── Top bar: relation block + pagination ── *}
    <div class="mm-topbar" id="mailManagerActions">
        <div class="mm-relation" id="relationBlock"></div>
        <div class="mm-pagination">
            <button type="button" class="btn mailPagination"
                {if $MAIL->msgno() < $FOLDER->count()}
                    data-folder='{$FOLDER->name()}' data-msgno='{$MAIL->msgno(1)}'
                {else}disabled="disabled"{/if}>
                <i class="fa fa-caret-left"></i>
            </button>
            <button type="button" class="btn mailPagination"
                {if $MAIL->msgno() > 1}
                    data-folder='{$FOLDER->name()}' data-msgno='{$MAIL->msgno(-1)}'
                {else}disabled="disabled"{/if}>
                <i class="fa fa-caret-right"></i>
            </button>
        </div>
    </div>

    {* ── Mail card ── *}
    <div class="mm-card">

        {* Subject *}
        <div class="mm-subject-bar">
            <h4>{$MAIL->subject()}</h4>
        </div>

        {* Sender / metadata / actions *}
        {assign var=NAME       value=$MAIL->from()}
        {assign var=FIRST_CHAR value=strtoupper(substr($NAME[0], 0, 1))}
        {if $FOLDER->isSentFolder()}
            {assign var=NAME value=$MAIL->to()}
            {if $NAME|@count > 0}
                {assign var=FIRST_CHAR value=strtoupper(substr($NAME[0], 0, 1))}
            {else}
                {assign var=FIRST_CHAR value=''}
            {/if}
        {/if}
        {assign var=FROM value=$MAIL->from()}

        <div class="mm-sender-row">

            {* Avatar *}
            <div class="mm-avatar">{$FIRST_CHAR}</div>

            {* Meta *}
            <div class="mm-meta-block">
                <div class="mm-sender-name">
                    {if $FOLDER->isSentFolder()}
                        {implode(', ', $MAIL->to())}
                    {else}
                        {$NAME[0]}
                    {/if}
                    {if $ATTACHMENT_COUNT}
                        <span class="mm-attach-icon">
                            <i class="fa fa-paperclip"></i> {$ATTACHMENT_COUNT}
                        </span>
                    {/if}
                </div>

                {* Always-visible metadata grid *}
                <div class="mm-fields">
                    <span class="mm-field-label">{vtranslate('LBL_FROM', $MODULE)}</span>
                    <span class="mm-field-value">{$FROM[0]}</span>

                    <span class="mm-field-label">{vtranslate('LBL_TO', $MODULE)}</span>
                    <span class="mm-field-value">
                        {foreach from=$MAIL->to() item=TO_VAL name=toloop}
                            {$TO_VAL}{if not $smarty.foreach.toloop.last}, {/if}
                        {/foreach}
                    </span>

                    {if $MAIL->cc()}
                        <span class="mm-field-label">{vtranslate('LBL_CC_SMALL', $MODULE)}</span>
                        <span class="mm-field-value">
                            {foreach from=$MAIL->cc() item=CC_VAL name=ccloop}
                                {$CC_VAL}{if not $smarty.foreach.ccloop.last}, {/if}
                            {/foreach}
                        </span>
                    {/if}

                    {if $MAIL->bcc()}
                        <span class="mm-field-label">{vtranslate('LBL_BCC_SMALL', $MODULE)}</span>
                        <span class="mm-field-value">
                            {foreach from=$MAIL->bcc() item=BCC_VAL name=bccloop}
                                {$BCC_VAL}{if not $smarty.foreach.bccloop.last}, {/if}
                            {/foreach}
                        </span>
                    {/if}
                </div>
            </div>

            {* Date + action icons *}
            <div class="mm-date-actions">
                <span class="mm-date">{Vtiger_Util_Helper::formatDateTimeIntoDayString($MAIL->date(), true)}</span>
                <div class="mm-actions">
                    <a  class="mm-action-btn" id="mmPrint"     title="{vtranslate('LBL_Print',     $MODULE)}"><i class="fa fa-print"></i></a>
                    <a  class="mm-action-btn" id="mmReply"     title="{vtranslate('LBL_Reply',     $MODULE)}"><i class="fa fa-reply"></i></a>
                    <a  class="mm-action-btn" id="mmReplyAll"  title="{vtranslate('LBL_Reply_All', $MODULE)}"><i class="fa fa-reply-all"></i></a>
                    <a  class="mm-action-btn" id="mmForward"   title="{vtranslate('LBL_Forward',   $MODULE)}"><i class="fa fa-share"></i></a>
                    <a  class="mm-action-btn mm-delete" id="mmDelete" title="{vtranslate('LBL_Delete', $MODULE)}"><i class="fa fa-trash-o"></i></a>
                </div>
            </div>

        </div>{* /mm-sender-row *}

        {* Body *}
        <div class="mm-body-area">
            <div id="mmBody">{$BODY}</div>
        </div>

        {* Attachments *}
        {if $ATTACHMENT_COUNT}
            <div class="mm-attachments">
                <div class="mm-attachments-title">
                    {vtranslate('LBL_Attachments', $MODULE)}
                    &nbsp;({$ATTACHMENT_COUNT}&nbsp;{vtranslate('LBL_FILES', $MODULE)})
                </div>
                <div class="mm-attach-list">
                    {foreach item=ATTACHVALUE from=$ATTACHMENTS name="attach"}
                        {assign var=ATTACHNAME value=$ATTACHVALUE['filename']}
                        {if $INLINE_ATT[$ATTACHNAME] eq null}
                            {assign var=DOWNLOAD_LINK value=$ATTACHNAME|@escape:'url'}
                            {assign var=ATTACHID      value=$ATTACHVALUE['attachid']}
                            <a class="mm-attach-item"
                               href="index.php?module={$MODULE}&view=Index&_operation=mail&_operationarg=attachment_dld&_muid={$MAIL->muid()}&_atid={$ATTACHID}&_atname={$DOWNLOAD_LINK|@escape:'htmlall':'UTF-8'}">
                                <i class="fa {$MAIL->getAttachmentIcon($ATTACHVALUE['path'])}"></i>
                                {$ATTACHNAME}
                                <span class="mm-attach-size">({$ATTACHVALUE['size']})</span>
                                <i class="fa fa-download mm-attach-dl"></i>
                            </a>
                        {/if}
                    {/foreach}
                </div>
            </div>
        {/if}

    </div>{* /mm-card *}
</div>{* /mm-wrap *}

{/strip}
