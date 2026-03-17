{
  description = "Jekyll Chirpy blog dev environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          ruby_3_3
          bundler
          gcc
          gnumake
          zlib
          libffi
          libyaml
        ];

        shellHook = ''
          export GEM_HOME="$PWD/.gems"
          export GEM_PATH="$GEM_HOME"
          export PATH="$GEM_HOME/bin:$PATH"
          export BUNDLE_PATH="$PWD/.bundle"

          echo "Jekyll dev environment ready."
          echo "Run: bundle install && bundle exec jekyll serve"
        '';
      };
    };
}
