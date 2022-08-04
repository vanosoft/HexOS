include "include/macroefi.inc"

mEntry main

include "include/sysuefi.inc"

mSect text, code

main:
    mInit
    mClear
    ;mBusyticks 10 ; doesn't work yet
    mPrintln hello, warn
    mNewline
mAnonymous:
    mNewline
    mPrint pathOS, pathSep, pathUser, pathSep, pathDir, pathPrompt
    mScanln command
    jmp left
    mExit EFI_SUCCESS
 
include "include/libuefi.inc"

mSect bsdata, data

hello sString 'Welcome to VUS-'

warn sString 'Warn: You are logged in as admin'

message sString 'Just useless message.'

pathPrompt sString '> '

pathOS sString 'HexOS'

pathUser sString 'admin'

pathDir sString '/PC/'
mAnonymous du null dup (1024-10) ; 10 = len("/PC/") + len(null)

pathSep sString ' : '

key sKey

command sStrbuf 256

mEfidata
