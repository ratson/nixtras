{ mkDerivation
, fetchFromGitHub
, aeson
, base
, base64
, bytestring
, containers
, directory
, hsyslog
, http-conduit
, lib
, network-uri
, optparse-applicative
, pretty-simple
, process
, random
, strings
, template-haskell
, text
, time
, twain
, unix
, utf8-string
, warp
, yaml
, input
, inputVersion
, string-qq
}:

let
  deps = [
    aeson
    base
    base64
    bytestring
    containers
    directory
    hsyslog
    http-conduit
    network-uri
    optparse-applicative
    pretty-simple
    process
    random
    strings
    template-haskell
    text
    time
    twain
    unix
    utf8-string
    warp
    yaml
    string-qq
  ];
in
mkDerivation {
  pname = "oama";
  version = inputVersion input;

  src = input;

  isLibrary = true;
  isExecutable = true;

  libraryHaskellDepends = deps;
  executableHaskellDepends = deps;

  description = "OAuth credential Manager";
  homepage = "https://github.com/pdobsan/oama";
  license = lib.licenses.bsd3;
  mainProgram = "oama";
}
