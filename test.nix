self: super: {
  ...
}

nixpkgs = import <nixpkgs> {
  overlays = [
    (self: super: {
      callPackage = (path: builtins.trace "callPackage - ${toString path}" (super.callPackage path)
    );
    })
  ];
}

let fix = f: let fixpoint = f fixpoint; in fixpoint;
