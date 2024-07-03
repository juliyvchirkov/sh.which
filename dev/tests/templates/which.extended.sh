Describe "${shellfulltitle}"
  Skip if "${shellbintitle} shell is not available" [ ! -x ${shellbin} ]

  Include ../src/which.extended.sh

  Example "Extended edition: which"
    When call which
    The line 1 of stderr should equal "which: locates command(s) and reports to standard output"
    The line 3 of stderr should equal "USAGE"
    The line 4 of stderr should equal "    which [-ias] command …"
    The line 5 of stderr should equal "OPTIONS"
    The line 9 of stderr should equal "EXIT STATUS"
    The status should equal 1
  End

  Example "Extended edition: which -f ${shellbinary}"
    When call which -f ${shellbinary}
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "f"
    The status should equal 2
  End

  Example "Extended edition: which ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which ${shellbinary}

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Extended edition: which -a ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -a ${shellbinary}

    PATH="${path}"

    The line 1 of stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Extended edition: which -s ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -s ${shellbinary}

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which command"
    When call which command
    The stdout should equal "command"
    The status should equal 0
  End

  Example "Extended edition: which -i command"
    path="${PATH}"
    PATH="${testsbin}"

    When call which -i command

    PATH="${path}"

    The status should equal 1
  End

  Example "Extended edition: which which"
    When call which which
    The stdout should equal "which"
    The status should equal 0
  End

  Example "Extended edition: which -a which"
    path="${PATH}"
    PATH="${testsbin}:${PATH}"

    When call which -a which

    PATH="${path}"

    The line 1 of stdout should equal "which"
    The line 2 of stdout should equal "${testsbin}/which"
    The status should equal 0
  End

  Example "Extended edition: which -ia which"
    path="${PATH}"
    PATH="${testsbin}:${PATH}"

    When call which -ia which

    PATH="${path}"

    The line 1 of stdout should equal "${testsbin}/which"
    The status should equal 0
  End

  Example "Extended edition: which -ai which"
    path="${PATH}"
    PATH="${testsbin}:${PATH}"

    When call which -ai which

    PATH="${path}"

    The line 1 of stdout should equal "${testsbin}/which"
    The status should equal 0
  End

  Example "Extended edition: which -s which"
    When call which -s which
    The status should equal 0
  End

  Example "Extended edition: which -is which"
    path="${PATH}"
    PATH="${testsbin}:${PATH}"

    When call which -is which

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -si which"
    path="${PATH}"
    PATH="${testsbin}:${PATH}"

    When call which -si which

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which ${shellbinary} shellcheck which"
    path="${PATH}"
    devbin="${testsbin}"
    devshellbin="${extrapath}"
    PATH="${devbin}:${PATH}"
    [ "${devbin}" = "${devshellbin}" ] || PATH="${devshellbin}:${PATH}"

    When call which ${shellbinary} shellcheck which

    PATH="${path}"

    The line 1 of stdout should equal "${shebang}"
    The line 2 of stdout should equal "${testsbin}/shellcheck"
    The line 3 of stdout should equal "which"
    The status should equal 0
  End

  Example "Extended edition: which -i ${shellbinary} shellcheck which"
    path="${PATH}"
    devbin="${testsbin}"
    devshellbin="${extrapath}"
    PATH="${devbin}:${PATH}"
    [ "${devbin}" = "${devshellbin}" ] || PATH="${devshellbin}:${PATH}"

    When call which -i ${shellbinary} shellcheck which

    PATH="${path}"

    The line 1 of stdout should equal "${shebang}"
    The line 2 of stdout should equal "${testsbin}/shellcheck"
    The line 3 of stdout should equal "${testsbin}/which"
    The status should equal 0
  End

  Example "Extended edition: which -a which shellcheck ${shellbinary}"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -a which shellcheck ${shellbinary}

    PATH="${path}"

    The line 1 of stdout should equal "which"
    The line 2 of stdout should equal "${testsbin}/which"
    The line 3 of stdout should equal "${testsbin}/shellcheck"
    The line 4 of stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Extended edition: which -ia shellcheck which ${shellbinary}"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -ia shellcheck which ${shellbinary}

    PATH="${path}"

    The line 1 of stdout should equal "${testsbin}/shellcheck"
    The line 2 of stdout should equal "${testsbin}/which"
    The line 3 of stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Extended edition: which -ai which shellcheck ${shellbinary}"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -ai which shellcheck ${shellbinary}

    PATH="${path}"

    The line 1 of stdout should equal "${testsbin}/which"
    The line 2 of stdout should equal "${testsbin}/shellcheck"
    The line 3 of stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Extended edition: which nonexistent-command"
    When call which nonexistent-command
    The status should equal 1
  End

  Example "Extended edition: which ${shellbinary} shellcheck nonexistent-command"
    path="${PATH}"
    devbin="${testsbin}"
    devshellbin="${extrapath}"
    PATH="${devbin}:${PATH}"
    [ "${devbin}" = "${devshellbin}" ] || PATH="${devshellbin}:${PATH}"

    When call which ${shellbinary} shellcheck nonexistent-command

    PATH="${path}"

    The line 1 of stdout should equal "${shebang}"
    The line 2 of stdout should equal "${testsbin}/shellcheck"
    The status should equal 1
  End

  Example "Extended edition: which -a shellcheck ${shellbinary} nonexistent-command"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -a shellcheck ${shellbinary} nonexistent-command

    PATH="${path}"

    The line 1 of stdout should equal "${testsbin}/shellcheck"
    The line 2 of stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Extended edition: which -s nonexistent-command"
    When call which -s nonexistent-command
    The status should equal 1
  End

  Example "Extended edition: which -as shellcheck ${shellbinary} which"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -as shellcheck ${shellbinary} which

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -sa which ${shellbinary} shellcheck"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -sa which ${shellbinary} shellcheck

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -a -s shellcheck which ${shellbinary}"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -a -s shellcheck which ${shellbinary}

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -s -a which ${shellbinary} shellcheck"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -s -a which ${shellbinary} shellcheck

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -i -a -s shellcheck which ${shellbinary}"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -i -a -s shellcheck which ${shellbinary}

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -i -s -a which ${shellbinary} shellcheck"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -i -s -a which ${shellbinary} shellcheck

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -a -i -s shellcheck which ${shellbinary}"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -a -i -s shellcheck which ${shellbinary}

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -s -i -a which ${shellbinary} shellcheck"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -s -i -a which ${shellbinary} shellcheck

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -a -s -i shellcheck which ${shellbinary}"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -a -s -i shellcheck which ${shellbinary}

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -s -a -i which ${shellbinary} shellcheck"
    path="${PATH}"
    PATH="${testsbin}"
    [ "${PATH}" = "${extrapath}" ] || PATH="${extrapath}:${PATH}"

    When call which -s -a -i which ${shellbinary} shellcheck

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -i -a -s -f shellcheck ${shellbinary}"
    When call which -i -a -s -f shellcheck ${shellbinary}
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "f"
    The status should equal 2
  End

  Example "Extended edition: which -f -i -a -s shellcheck ${shellbinary}"
    When call which -f -i -a -s shellcheck ${shellbinary}
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "f"
    The status should equal 2
  End

  Example "Extended edition: which -iasf shellcheck ${shellbinary}"
    When call which -iasf shellcheck ${shellbinary}
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "iasf"
    The status should equal 2
  End

  Example "Extended edition: which -isaf ${shellbinary} shellcheck"
    When call which -isaf ${shellbinary} shellcheck
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "isaf"
    The status should equal 2
  End

  Example "Extended edition: which -aisf shellcheck ${shellbinary}"
    When call which -aisf shellcheck ${shellbinary}
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "aisf"
    The status should equal 2
  End

  Example "Extended edition: which -asif ${shellbinary} shellcheck"
    When call which -asif ${shellbinary} shellcheck
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "asif"
    The status should equal 2
  End

  Example "Extended edition: which -saif shellcheck ${shellbinary}"
    When call which -saif shellcheck ${shellbinary}
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "saif"
    The status should equal 2
  End

  Example "Extended edition: which -siaf ${shellbinary} shellcheck"
    When call which -siaf ${shellbinary} shellcheck
    The word 2 of stderr should equal "invalid"
    The word 5 of stderr should equal "siaf"
    The status should equal 2
  End

  Example "Extended edition: which -- ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -- ${shellbinary}

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Extended edition: which -a -- ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -a -- ${shellbinary}

    PATH="${path}"

    The line 1 of stdout should equal "${shebang}"
    The status should equal 0
  End

  Example "Extended edition: which -s -- ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -s -- ${shellbinary}

    PATH="${path}"

    The status should equal 0
  End

  Example "Extended edition: which -- -a ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -- -a ${shellbinary}

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Extended edition: which -- -s ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -- -s ${shellbinary}

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Extended edition: which -- -a -s ${shellbinary}"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which -- -a -s ${shellbinary}

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Extended edition: which ${shellbinary} -a"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which ${shellbinary} -a

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Extended edition: which ${shellbinary} -s"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which ${shellbinary} -s

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Extended edition: which ${shellbinary} -as"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which ${shellbinary} -as

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End

  Example "Extended edition: which ${shellbinary} -sa"
    path="${PATH}"
    PATH="${extrapath}:${PATH}"

    When call which ${shellbinary} -sa

    PATH="${path}"

    The stdout should equal "${shebang}"
    The status should equal 1
  End
End
