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

    /* ── Relation block wrapper ── */
    .mr-wrap {
        font-family: 'DM Sans', sans-serif;
        display: flex;
        align-items: flex-start;
        gap: 10px;
        padding: 6px 0;
        flex-wrap: wrap;
    }

    /* ── Linked records list ── */
    .mr-records {
        flex: 1;
        min-width: 0;
        display: flex;
        flex-direction: column;
        gap: 4px;
    }

    .mr-record-row {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 5px 8px;
        border-radius: 6px;
        background: #f8f9fb;
        border: 1px solid #e8eaed;
        transition: border-color 0.13s, background 0.13s;
    }

    .mr-record-row:hover {
        background: #f0f2fb;
        border-color: #c7d0f8;
    }

    /* Radio button */
    .mr-record-row input[type="radio"] {
        accent-color: #4f6ef7;
        flex-shrink: 0;
        width: 14px;
        height: 14px;
        cursor: pointer;
        margin: 0;
    }

    /* Record label */
    .mr-record-label {
        flex: 1;
        font-size: 12.5px;
        color: #374151;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .mr-record-label a {
        color: #4f6ef7;
        text-decoration: none;
        font-weight: 500;
    }
    .mr-record-label a:hover { text-decoration: underline; }

    .mr-record-module {
        font-size: 11px;
        color: #9ca3af;
        background: #e8eaed;
        border-radius: 4px;
        padding: 1px 6px;
        white-space: nowrap;
        flex-shrink: 0;
        font-weight: 500;
    }

    /* ── Actions dropdown ── */
    .mr-actions-wrap {
        flex-shrink: 0;
        position: relative;
    }

    /* Hide native select — we build a custom styled one */
    .mr-actions-wrap select#_mlinktotype {
        appearance: none;
        -webkit-appearance: none;
        background: #ffffff !important;
        border: 1px solid #e5e7eb !important;
        border-radius: 8px !important;
        padding: 6px 32px 6px 12px !important;
        font-size: 12.5px !important;
        font-family: 'DM Sans', sans-serif !important;
        font-weight: 500 !important;
        color: #374151 !important;
        cursor: pointer !important;
        outline: none !important;
        box-shadow: 0 1px 3px rgba(0,0,0,0.06) !important;
        transition: border-color 0.15s, box-shadow 0.15s !important;
        min-width: 140px !important;
        max-width: 180px !important;
        height: 32px !important;
        line-height: 1 !important;
        background-image: none !important;
    }

    .mr-actions-wrap select#_mlinktotype:focus,
    .mr-actions-wrap select#_mlinktotype:hover {
        border-color: #4f6ef7 !important;
        box-shadow: 0 0 0 3px rgba(79,110,247,0.10) !important;
    }

    /* Custom caret via pseudo — wraps the select */
    .mr-select-shell {
        position: relative;
        display: inline-block;
    }

    .mr-select-shell::after {
        content: '\f107'; /* fa-angle-down */
        font-family: 'FontAwesome';
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        color: #6b7280;
        font-size: 13px;
        pointer-events: none;
    }

    /* ── Empty record area spacer ── */
    .mr-spacer { min-height: 10px; }
</style>

{if isset($LINKEDTO) && $LINKEDTO}
    <div class="mr-wrap">
        {* Single linked record *}
        <div class="mr-records recordScroll">
            <div class="mr-record-row">
                <input type="radio" name="_mlinkto" value="{$LINKEDTO.record}">
                <span class="mr-record-label textOverflowEllipsis" title="{$LINKEDTO.detailviewlink}">
                    {$LINKEDTO.detailviewlink}
                </span>
                <span class="mr-record-module">{vtranslate($LINKEDTO.module, $moduleName)}</span>
            </div>
        </div>

        {if $LINK_TO_AVAILABLE_ACTIONS|count neq 0}
            <div class="mr-actions-wrap">
                <div class="mr-select-shell">
                    <select name="_mlinktotype" id="_mlinktotype" data-action='associate'>
                        <option value="">{vtranslate('LBL_ACTIONS', $MODULE)}</option>
                        {foreach item=moduleName from=$LINK_TO_AVAILABLE_ACTIONS}
                            {if $moduleName eq 'Calendar'}
                                <option value="{$moduleName}">{vtranslate("LBL_ADD_CALENDAR", 'MailManager')}</option>
                                <option value="Events">{vtranslate("LBL_ADD_EVENTS", 'MailManager')}</option>
                            {else}
                                <option value="{$moduleName}">{vtranslate("LBL_MAILMANAGER_ADD_$moduleName", 'MailManager')}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>
            </div>
        {/if}
    </div>

{/if}

{if $LOOKUPS}
    {assign var="LOOKRECATLEASTONE" value=false}
    {foreach item=RECORDS key=MODULE from=$LOOKUPS}
        {foreach item=RECORD from=$RECORDS}
            {assign var="LOOKRECATLEASTONE" value=true}
        {/foreach}
    {/foreach}

    <div class="mr-wrap">
        {* Multiple lookup records *}
        <div class="mr-records recordScroll">
            {foreach item=RECORDS key=MODULE from=$LOOKUPS}
                {foreach item=RECORD from=$RECORDS}
                    <div class="mr-record-row">
                        <input type="radio" name="_mlinkto" value="{$RECORD.id}">
                        <span class="mr-record-label textOverflowEllipsis" title="{$RECORD.label}">
                            <a target="_blank" href='index.php?module={$MODULE}&view=Detail&record={$RECORD.id}'>
                                {$RECORD.label|textlength_check}
                            </a>
                        </span>
                        {assign var="SINGLE_MODLABEL" value="SINGLE_$MODULE"}
                        <span class="mr-record-module">{vtranslate($SINGLE_MODLABEL, $MODULE)}</span>
                    </div>
                {/foreach}
            {/foreach}
        </div>

        <div class="mr-actions-wrap">
            <div class="mr-select-shell">
                {if $LOOKRECATLEASTONE}
                    {if $LINK_TO_AVAILABLE_ACTIONS|count neq 0}
                        <select name="_mlinktotype" id="_mlinktotype" data-action='associate'>
                            <option value="">{vtranslate('LBL_ACTIONS', $MODULE)}</option>
                            {foreach item=moduleName from=$LINK_TO_AVAILABLE_ACTIONS}
                                {if $moduleName eq 'Calendar'}
                                    <option value="{$moduleName}">{vtranslate("LBL_ADD_CALENDAR", 'MailManager')}</option>
                                    <option value="Events">{vtranslate("LBL_ADD_EVENTS", 'MailManager')}</option>
                                {else}
                                    <option value="{$moduleName}">{vtranslate("LBL_MAILMANAGER_ADD_$moduleName", 'MailManager')}</option>
                                {/if}
                            {/foreach}
                        </select>
                    {/if}
                {else}
                    {if $ALLOWED_MODULES|count neq 0}
                        <select name="_mlinktotype" id="_mlinktotype" data-action='create'>
                            <option value="">{vtranslate('LBL_ACTIONS', 'MailManager')}</option>
                            {foreach item=moduleName from=$ALLOWED_MODULES}
                                {if $moduleName eq 'Calendar'}
                                    <option value="{$moduleName}">{vtranslate("LBL_ADD_CALENDAR", 'MailManager')}</option>
                                    <option value="Events">{vtranslate("LBL_ADD_EVENTS", 'MailManager')}</option>
                                {else}
                                    <option value="{$moduleName}">{vtranslate("LBL_MAILMANAGER_ADD_$moduleName", 'MailManager')}</option>
                                {/if}
                            {/foreach}
                        </select>
                    {/if}
                {/if}
            </div>
        </div>
    </div>

{else}
    {if isset($LINKEDTO) && $LINKEDTO eq ""}
        <div class="mr-wrap">
            <div class="mr-records mr-spacer"></div>
            {if $ALLOWED_MODULES|count neq 0}
                <div class="mr-actions-wrap">
                    <div class="mr-select-shell">
                        <select name="_mlinktotype" id="_mlinktotype" data-action='create'>
                            <option value="">{vtranslate('LBL_ACTIONS', 'MailManager')}</option>
                            {foreach item=moduleName from=$ALLOWED_MODULES}
                                {if $moduleName eq 'Calendar'}
                                    <option value="{$moduleName}">{vtranslate("LBL_ADD_CALENDAR", 'MailManager')}</option>
                                    <option value="Events">{vtranslate("LBL_ADD_EVENTS", 'MailManager')}</option>
                                {else}
                                    <option value="{$moduleName}">{vtranslate("LBL_MAILMANAGER_ADD_$moduleName", 'MailManager')}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>
                </div>
            {/if}
        </div>
    {/if}
{/if}

{/strip}
