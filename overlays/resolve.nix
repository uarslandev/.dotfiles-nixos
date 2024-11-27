self: super:

let
  # Define the patched binary as a custom package
  patchedBinary = super.stdenv.mkDerivation {
    name = "resolve-patched-binary";
    src = ../resolve; # Replace with the path to your patched binary
    installPhase = ''
      mkdir -p $out/bin
      cp ${src} $out/bin/resolve
      chmod +x $out/bin/resolve
    '';
  };
in
# Override the DaVinci Resolve package to use the patched binary
super.davinci-resolve-studio.overrideAttrs (oldAttrs: {
  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ patchedBinary ];
})
