{
  outputs = _: { };

  inputs = {
    profile-sync-daemon = {
      url = "github:graysky2/profile-sync-daemon";
      flake = false;
    };
  };
}
