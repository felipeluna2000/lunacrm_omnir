{*+**********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.1
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ************************************************************************************}

<style>
    @import url('https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600&family=DM+Mono:wght@400;500&display=swap');

    /* ── Scoped to sidebar folder list ── */
    .fl-wrap {
        font-family: 'DM Sans', sans-serif;
        padding: 6px 0 12px;
    }

    .fl-wrap ul {
        list-style: none;
        margin: 0;
        padding: 0;
    }

    /* ── Each folder row ── */
    .fl-wrap .mm_folder {
        display: flex !important;
        align-items: center !important;
        gap: 9px !important;
        padding: 8px 12px 8px 14px !important;
        margin: 1px 4px !important;
        border-radius: 7px !important;
        cursor: pointer !important;
        transition: background 0.13s, color 0.13s !important;
        position: relative !important;
        color: rgba(255,255,255,0.65) !important;
        font-size: 13px !important;
        font-weight: 400 !important;
        text-decoration: none !important;
        list-style: none !important;
    }

    .fl-wrap .mm_folder:hover {
        background: rgba(255,255,255,0.10) !important;
        color: rgba(255,255,255,0.95) !important;
    }

    /* Active / selected folder */
    .fl-wrap .mm_folder.active {
        background: rgba(79,110,247,0.85) !important;
        color: #ffffff !important;
        font-weight: 600 !important;
        box-shadow: 0 2px 8px rgba(79,110,247,0.35) !important;
    }

    .fl-wrap .mm_folder.active .fl-icon {
        color: #ffffff !important;
        opacity: 1 !important;
    }

    /* ── Icon ── */
    .fl-wrap .fl-icon {
        font-size: 14px !important;
        width: 16px !important;
        text-align: center !important;
        flex-shrink: 0 !important;
        color: rgba(255,255,255,0.45) !important;
        transition: color 0.13s !important;
    }

    .fl-wrap .mm_folder:hover .fl-icon {
        color: rgba(255,255,255,0.9) !important;
    }

    /* ── Label ── */
    .fl-wrap .fl-label {
        flex: 1 !important;
        white-space: nowrap !important;
        overflow: hidden !important;
        text-overflow: ellipsis !important;
        line-height: 1.3 !important;
    }

    /* ── Unread badge ── */
    .fl-wrap .mmUnreadCountBadge {
        background: rgba(255,255,255,0.20) !important;
        color: #ffffff !important;
        font-size: 10px !important;
        font-weight: 700 !important;
        font-family: 'DM Mono', monospace !important;
        min-width: 20px !important;
        height: 18px !important;
        border-radius: 9px !important;
        display: inline-flex !important;
        align-items: center !important;
        justify-content: center !important;
        padding: 0 5px !important;
        flex-shrink: 0 !important;
        line-height: 1 !important;
    }

    /* Active folder badge — slightly different so it pops */
    .fl-wrap .mm_folder.active .mmUnreadCountBadge {
        background: rgba(255,255,255,0.30) !important;
    }

    .fl-wrap .mmUnreadCountBadge.hide {
        display: none !important;
    }

    /* ── Section divider ── */
    .fl-divider {
        height: 1px !important;
        background: rgba(255,255,255,0.10) !important;
        margin: 10px 14px 6px !important;
    }

    /* ── Section label (e.g. "FOLDERS") ── */
    .fl-section-label {
        display: block !important;
        font-size: 10px !important;
        font-weight: 600 !important;
        text-transform: uppercase !important;
        letter-spacing: 0.9px !important;
        color: rgba(255,255,255,0.35) !important;
        padding: 4px 16px 6px !important;
        font-family: 'DM Sans', sans-serif !important;
    }

    /* ── Other folders slightly smaller ── */
    .fl-wrap .mmOtherFolder {
        font-size: 12.5px !important;
        padding: 7px 12px 7px 14px !important;
    }

    .fl-wrap .mmOtherFolder .fl-icon {
        font-size: 13px !important;
    }
</style>

{if isset($FOLDERS) && $FOLDERS}
    {assign var=INBOX_ADDED value=0}
    {assign var=TRASH_ADDED value=0}

    <div class="fl-wrap">
        <ul>

            {* ── Inbox + Drafts ── *}
            {foreach item=FOLDER from=$FOLDERS}
                {if stripos($FOLDER->name(), 'inbox') !== false && $INBOX_ADDED == 0}
                    {assign var=INBOX_ADDED value=1}
                    {assign var=INBOX_FOLDER value=$FOLDER->name()}

                    <li class="mm_folder mmMainFolder active" data-foldername="{$FOLDER->name()}">
                        <i class="fa fa-inbox fl-icon"></i>
                        <span class="fl-label">{vtranslate('LBL_INBOX', $MODULE)}</span>
                        <span class="mmUnreadCountBadge {if !$FOLDER->unreadCount()}hide{/if}">
                            {$FOLDER->unreadCount()}
                        </span>
                    </li>

                    <li class="mm_folder mmMainFolder" data-foldername="vt_drafts">
                        <i class="fa fa-pencil-square-o fl-icon"></i>
                        <span class="fl-label">{vtranslate('LBL_Drafts', $MODULE)}</span>
                    </li>
                {/if}
            {/foreach}

            {* ── Sent ── *}
            {foreach item=FOLDER from=$FOLDERS}
                {if $FOLDER->isSentFolder()}
                    {assign var=SENT_FOLDER value=$FOLDER->name()}
                    <li class="mm_folder mmMainFolder" data-foldername="{$FOLDER->name()}">
                        <i class="fa fa-paper-plane fl-icon"></i>
                        <span class="fl-label">{vtranslate('LBL_SENT', $MODULE)}</span>
                        <span class="mmUnreadCountBadge {if !$FOLDER->unreadCount()}hide{/if}">
                            {$FOLDER->unreadCount()}
                        </span>
                    </li>
                {/if}
            {/foreach}

            {* ── Trash ── *}
            {foreach item=FOLDER from=$FOLDERS}
                {if stripos($FOLDER->name(), 'trash') !== false && $TRASH_ADDED == 0}
                    {assign var=TRASH_ADDED value=1}
                    {assign var=TRASH_FOLDER value=$FOLDER->name()}
                    <li class="mm_folder mmMainFolder" data-foldername="{$FOLDER->name()}">
                        <i class="fa fa-trash-o fl-icon"></i>
                        <span class="fl-label">{vtranslate('LBL_TRASH', $MODULE)}</span>
                        <span class="mmUnreadCountBadge {if !$FOLDER->unreadCount()}hide{/if}">
                            {$FOLDER->unreadCount()}
                        </span>
                    </li>
                {/if}
            {/foreach}

            {* ── Other folders ── *}
            {if !isset($TRASH_FOLDER)}
                {assign var=TRASH_FOLDER value=''}
            {/if}
            {assign var=IGNORE_FOLDERS value=array($INBOX_FOLDER, $SENT_FOLDER, $TRASH_FOLDER)}

            {assign var=HAS_OTHER value=0}
            {foreach item=FOLDER from=$FOLDERS}
                {if !in_array($FOLDER->name(), $IGNORE_FOLDERS)}
                    {assign var=HAS_OTHER value=1}
                {/if}
            {/foreach}

            {if $HAS_OTHER}
                <li style="list-style:none; padding:0; margin:0;">
                    <div class="fl-divider"></div>
                    <span class="fl-section-label">{vtranslate('LBL_Folders', $MODULE)}</span>
                </li>
                {foreach item=FOLDER from=$FOLDERS}
                    {if !in_array($FOLDER->name(), $IGNORE_FOLDERS)}
                        <li class="mm_folder mmOtherFolder" data-foldername="{$FOLDER->name()}">
                            <i class="fa fa-folder-o fl-icon"></i>
                            <span class="fl-label">{$FOLDER->name()}</span>
                            <span class="mmUnreadCountBadge {if !$FOLDER->unreadCount()}hide{/if}">
                                {$FOLDER->unreadCount()}
                            </span>
                        </li>
                    {/if}
                {/foreach}
            {/if}

        </ul>
    </div>
{/if}
