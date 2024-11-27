self: super:

let
  # Define the patched binary as a custom package
  patchedBinary = super.stdenv.mkDerivation {
    name = "resolve-patched-binary";

    # Replace this with the absolute path to your patched binary
    src = /home/umut/path/to/your/patched-binary;

    installPhase = ''
      mkdir -p $out/bin
      cp ${src} $out/bin/resolve
      chmod +x $out/bin/resolve
    '';
  };
in
# Override the DaVinci Resolve package to use the patched binary
super.davinci-resolve.overrideAttrs (oldAttrs: {
  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ patchedBinary ];
})

