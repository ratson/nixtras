{ fetchFromGitHub, python3, ... }:

python3.pkgs.buildPythonApplication {
  pname = "cmake-lint";
  version = "1.4.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "cmake-lint";
    repo = "cmake-lint";
    rev = "7c644095eb566fa805839ad53b733f7bcdb73032";
    hash = "sha256-/OuWwerBlJynEibaYo+jkLpHt4x9GZrqMRJNxgrDBlM=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
  ];

  pythonImportsCheck = [ "cmakelint" ];

  meta = {
    mainProgram = "cmakelint";
  };
}
