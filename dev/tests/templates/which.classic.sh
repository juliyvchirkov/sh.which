Describe "${shellfulltitle}"
  Skip if "${shellbintitle} shell is not available" [ ! -x ${shellbin} ]

  Include ../src/which.classic.sh

  Example "Classic edition: which"
    When call which
    The line 1 of stderr should equal "which: locates command(s) and reports to standard output"
    The line 3 of stderr should equal "USAGE"
    The line 4 of stderr should equal "    which [-as] command …"
    The line 5 of stderr should equal "OPTIONS"
    The line 8 of stderr should equal "EXIT STATUS"
    The status should equal 1
  End

  Example "Classic edition: which -f ${shellbinary}"
    When call which -f ${shellbinary}
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "f"
    The status should equal 2
  End

  Example "Classic edition: which ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which ${shellbinary}

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Classic edition: which -a ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -a ${shellbinary}

    PATH="${path}"

    The line 1 of stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Classic edition: which -s ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -s ${shellbinary}

    PATH="${path}"

    The status should equal 0
  End

  Example "Classic edition: which ${shellbinary} shellspec"
    path="${PATH}"
    devbin="${testsbin}"
    devshellbin="${extrapath}"
    PATH="${devbin}:${PATH}"
    [ "${devbin}" = "${devshellbin}" ] || PATH="${devshellbin}:${PATH}"

    When call which ${shellbinary} shellspec

    PATH="${path}"

    The line 1 of stdout should equal "${shebang}"
    The line 2 of stdout should equal "${testsbin}/shellspec"
    The status should equal 0
  End

  Example "Classic edition: which -a shellspec ${shellbinary}"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -a shellspec ${shellbinary}

    PATH="${path}"

    The line 1 of stdout should equal "${testsbin}/shellspec"
    The line 2 of stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Classic edition: which nonexistent-command"
    When call which nonexistent-command
    The status should equal 1
  End

  Example "Classic edition: which ${shellbinary} shellspec nonexistent-command"
    path="${PATH}"
    devbin="${testsbin}"
    devshellbin="${extrapath}"
    PATH="${devbin}:${PATH}"
    [ "${devbin}" = "${devshellbin}" ] || PATH="${devshellbin}:${PATH}"

    When call which ${shellbinary} shellspec nonexistent-command

    PATH="${path}"

    The line 1 of stdout should equal "${shebang}"
    The line 2 of stdout should equal "${testsbin}/shellspec"
    The status should equal 1
  End

  Example "Classic edition: which -a shellspec ${shellbinary} nonexistent-command"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -a shellspec ${shellbinary} nonexistent-command

    PATH="${path}"

    The line 1 of stdout should equal "${testsbin}/shellspec"
    The line 2 of stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Classic edition: which -s nonexistent-command"
    When call which -s nonexistent-command
    The status should equal 1
  End

  Example "Classic edition: which -as shellspec ${shellbinary}"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -as shellspec ${shellbinary}

    PATH="${path}"

    The status should equal 0
  End

  Example "Classic edition: which -sa ${shellbinary} shellspec"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -sa ${shellbinary} shellspec

    PATH="${path}"

    The status should equal 0
  End

  Example "Classic edition: which -a -s shellspec ${shellbinary}"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -a -s shellspec ${shellbinary}

    PATH="${path}"

    The status should equal 0
  End

  Example "Classic edition: which -s -a ${shellbinary} shellspec"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -s -a ${shellbinary} shellspec

    PATH="${path}"

    The status should equal 0
  End

  Example "Classic edition: which -a -s -f shellspec ${shellbinary}"
    When call which -a -s -f shellspec ${shellbinary}
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "f"
    The status should equal 2
  End

  Example "Classic edition: which -f -a -s shellspec ${shellbinary}"
    When call which -f -a -s shellspec ${shellbinary}
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "f"
    The status should equal 2
  End

  Example "Classic edition: which -asf shellspec ${shellbinary}"
    When call which -asf shellspec ${shellbinary}
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "asf"
    The status should equal 2
  End

  Example "Classic edition: which -saf ${shellbinary} shellspec"
    When call which -saf ${shellbinary} shellspec
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "saf"
    The status should equal 2
  End

  Example "Classic edition: which -- ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -- ${shellbinary}

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Classic edition: which -a -- ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -a -- ${shellbinary}

    PATH="${path}"

    The line 1 of stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Classic edition: which -s -- ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -s -- ${shellbinary}

    PATH="${path}"

    The status should equal 0
  End

  Example "Classic edition: which -- -a ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -- -a ${shellbinary}

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Classic edition: which -- -s ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -- -s ${shellbinary}

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Classic edition: which -- -a -s ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -- -a -s ${shellbinary}

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Classic edition: which ${shellbinary} -a"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which ${shellbinary} -a

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Classic edition: which ${shellbinary} -s"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which ${shellbinary} -s

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Classic edition: which ${shellbinary} -as"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which ${shellbinary} -as

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Classic edition: which ${shellbinary} -sa"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which ${shellbinary} -sa

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End
End
