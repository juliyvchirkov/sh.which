Describe "shellcheck"
  Skip if "shellcheck command is not installed" [ ! -x bin/shellcheck ]

  Example "which.classic.sh"
    When run bin/shellcheck --shell=sh --format=quiet ../src/which.classic.sh
    The status should equal 0
  End

  Example "which.extended.sh"
    When run bin/shellcheck --shell=sh --format=quiet ../src/which.extended.sh
    The status should equal 0
  End
End
