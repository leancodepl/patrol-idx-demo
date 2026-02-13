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
      onCreate = {
        # Upgrade Flutter to version 3.38.4 to match pubspec.yaml
        upgrade-flutter = ''
          flutter channel stable
          flutter upgrade --force
          flutter --version
        '';
      };

      onStart = {
        default.openFiles = [ "patrol_test/demo_test.dart" ];
        patrol-develop = "emulator
        cd ./android && ./gradlew :clean && ./gradlew --stop && cd ..
        rm -rf ./build
        rm -rf ~/.gradle/caches
        flutter pub get
        flutter pub global activate patrol_cli 4.1.0
        while true; do
        flutter devices
    DEVICE_ID=$(flutter devices --machine | jq '.[0] | .id' -r)
    if [[ \"$DEVICE_ID\" =~ \"emulator\" ]]; then
      break
    fi
    echo \"Device not ready yet. Retrying in 5 seconds...\"
    sleep 5
  done
  flutter build apk --config-only -t lib/main.dart
  patrol develop -t patrol_test/demo_test.dart --flavor dev  --verbose";
      };
      
      # To run something each time the workspace is (re)started, use the `onStart` hook
    };
    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = {
        android = {
          #command = ["patrol" "develop" "-t" "patrol_test/quiz_test.dart" "--machine" "-d" "android" "-d" "localhost:5555"];
          command = ["yes"];
          manager = "android";
        };
      };
    };
  };
}
