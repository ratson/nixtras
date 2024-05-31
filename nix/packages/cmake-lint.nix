{ python3, inputs, ... }:

python3.pkgs.buildPythonApplication {
  pname = "cmake-lint";
  version = "1.4.3";
  pyproject = true;

  src = inputs.cmake-lint;

  nativeBuildInputs = [
    python3.pkgs.setuptools
  ];

  pythonImportsCheck = [ "cmakelint" ];

  meta = {
    mainProgram = "cmakelint";
  };
}
