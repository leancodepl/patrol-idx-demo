# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.jdk17
    pkgs.unzip
  ];
  # Sets environment variables in the workspace
  env = {
    CI = "true";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = { };

      onStart = {
        default.openFiles = [ "integration_test/quiz_test.dart" ];
        patrol-develop = "flutter pub get
        flutter pub global activate patrol_cli 3.4.0
        for i in {1..10}; do
    DEVICE_ID=$(adb devices | grep 'emulator-.*' | awk '{print $1}')
    if [ -n \"$DEVICE_ID\" ]; then
      break
    fi
    echo \"Device not ready yet. Retrying in 5 seconds...\"
    sleep 5
  done
  patrol develop -t integration_test/quiz_test.dart --flavor dev -d \"$DEVICE_ID\" ";
      };
      
      # To run something each time the workspace is (re)started, use the `onStart` hook
    };
    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = {
        android = {
          #command = ["patrol" "develop" "-t" "integration_test/quiz_test.dart" "--machine" "-d" "android" "-d" "localhost:5555"];
          command = ["yes"];
          manager = "android";
        };
      };
    };
  };
}
