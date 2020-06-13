{ lib
, isPy3k
, fetchFromGitHub
, buildPythonPackage
, flake8-import-order
, pyflakes
, mock
}:

buildPythonPackage rec {
  pname = "zimports";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "sqlalchemyorg";
    repo = "zimports";
    rev = version;
    sha256 = "0a5axflkk0wv0rdnrh8l2rgj8gh2pfkg5lrvr8x4yxxiifawrafc";
  };

  disabled = !isPy3k;

  propagatedBuildInputs = [
    pyflakes
    flake8-import-order
  ];

  checkInputs = [
    mock
  ];

  meta = with lib; {
    description = "Python import rewriter";
    homepage = "https://github.com/sqlalchemyorg/zimports";
    license = licenses.mit;
    maintainers = with maintainers; [ timokau ];
  };
}
