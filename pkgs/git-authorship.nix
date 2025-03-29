{
  fetchFromGitHub,
  python3Packages,
  ...
}:

let
  inherit (python3Packages)
    buildPythonPackage
    poetry-core
    gitpython
    plotly
    typing-extensions
    ;

  version = "0.4.0";
in
buildPythonPackage {
  inherit version;

  pname = "git-authorship";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "thehale";
    repo = "git-authorship";
    rev = "9c6927b59791eb71cce0a84d8c88fa14d5235fa8";
    hash = "sha256-ZCN+1pki1EhGhn1actarnsJMTG86YuZyyQBom8t8b90=";
  };

  build-system = [ poetry-core ];

  dependencies = [
    gitpython
    plotly
    typing-extensions
  ];

  meta = {
    mainProgram = "git-authorship";
  };
}
