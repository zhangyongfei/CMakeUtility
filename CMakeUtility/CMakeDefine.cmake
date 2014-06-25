FUNCTION(AddDefs DEFS)
    ADD_DEFINITIONS(${DEFS})
ENDFUNCTION(AddDefs)

FUNCTION(AddDefsWin32 DEFS)
IF(WIN32)
    AddDefs(${DEFS})
ENDIF()
ENDFUNCTION(AddDefsWin32)

FUNCTION(AddDefsLinux DEFS)
IF(UNIX AND NOT APPLE)
    AddDefs(${DEFS})
ENDIF()
ENDFUNCTION(AddDefsLinux)

FUNCTION(AddDefsOsx DEFS)
IF(APPLE)
    AddDefs(${DEFS})
ENDIF()
ENDFUNCTION(AddDefsOsx)

FUNCTION(AddDefsAndroid DEFS)
IF(ANDROID)
    AddDefs(${DEFS})
ENDIF()
ENDFUNCTION(AddDefsAndroid)
