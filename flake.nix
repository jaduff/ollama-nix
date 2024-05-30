{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

outputs =
	{ self
		, flake-utils
			, nixpkgs
	}:
	flake-utils.lib.eachDefaultSystem (
			system:
			let
			pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
			in
			{
			devShell = pkgs.mkShell {
			packages = with pkgs; [
# See https://github.com/NixOS/nixpkgs/issues/59209.
			bashInteractive
			(pkgs.ollama.override { acceleration = "cuda"; }) 
			];
			buildInputs = with pkgs; [

			];
			

    env = {
    OLLAMA_HOST="0.0.0.0:11434";
};


			shellHook = ''
			TRUST_REMOTE_CODE=True;
			'';
			};

			}
	);
}
