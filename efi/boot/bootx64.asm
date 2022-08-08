; text/plain

include "include/uefi+.inc"


mDefMacros

nl EQU cNl

mEntry main

mDefSystem

section ".text" code executable readable

main:
    mInit fatal_error
    mPrintln str_start_OK
    ;
    mPrintln str_admin_WARN
    mNewline
.command_loop:
    mNewline
    mScanln command
    ;
    mCompareStrings command, str_cmd_help
    je execute.help
    mCompareStrings command, str_cmd_exit
    je execute.exit
    mCompareStrings command, str_cmd_boot
    je execute.boot
    mCompareStringsPrefixes command, str_cmd_echo
    je execute.echo
    jmp .command_loop
    ;
.exit:
    ;
    mExit EFI_SUCCESS
;

fatal_error:
    mPrint str_fatal_FAIL
    mWaitkey kEnter
    mExit EFI_ERROR
    jmp fatal_error
;

execute:
.help:
    mPrintln str_help_NORM
    jmp main.command_loop
.echo:
    mPrintln command+10
    jmp main.command_loop
.exit:
    mPrint str_exit_NORM
@@:
    mScankey key
    cmp word [key.unicode], kEnter
    je main.exit
    cmp word [key.unicode], kEscape
    je main.command_loop
    jmp @b
.boot:
    mPrintln str_boot_FAIL
    jmp main.command_loop

mDefLibrary

section ".data" data readable writeable

str_start_OK sString '[  OK  ] Started: /efi/boot/boox64.efi'
str_admin_WARN sString "[ WARN ] You are logged in as admin"
str_fatal_FAIL sString '[ FAIL ] Fatal error occurred. Press [Enter] for exit...'
str_help_NORM sString 'VUS - Very Useless Shell', nl, nl, "help - shows this message", nl, 'echo [message] - echoes typed message', nl, "exit - exit VUS", nl, "boot - not implemented"
str_boot_FAIL sString "[ FAIL ] Not implemented"
str_exit_NORM sString "Press [Enter] for exit or [Esc] for cancel"
str_cmd_help sString "help"
str_cmd_echo sString "echo "
str_cmd_exit sString "exit"
str_cmd_boot sString "boot"

command sStrbuf 512

key sKey

mEfidata

section ".reloc" fixups data discardable
