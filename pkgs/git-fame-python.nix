{
  fetchFromGitHub,
  python3Packages,
  ...
}:

let
  inherit (python3Packages)
    buildPythonApplication
    buildPythonPackage
    setuptools-scm
    wheel
    tabulate
    tqdm
    ;

  argopt =
    let
      version = "0.9.1";
    in
    buildPythonPackage {
      inherit version;

      pname = "argopt";
      format = "pyproject";

      src = fetchFromGitHub {
        owner = "casperdcl";
        repo = "argopt";
        tag = "v${version}";
        hash = "sha256-6ijyFrZZoN5CK5DpKoaR5talyo9tm8pPn1dO7CARVOE=";
      };

      nativeBuildInputs = [
        setuptools-scm
        wheel
      ];
    };

  version = "2.1.0";
in
buildPythonApplication {
  inherit version;

  pname = "git-fame-python";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "casperdcl";
    repo = "git-fame";
    tag = "v${version}";
    hash = "sha256-ujd3OSsAvMgfE2AHnH3glcNvu93Tki+L5Lj7+62JkBQ=";
  };

  nativeBuildInputs = [
    setuptools-scm
    wheel
  ];

  propagatedBuildInputs = [
    argopt
    tabulate
    tqdm
  ];

  meta = {
    mainProgram = "git-fame";
  };
}
