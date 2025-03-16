self: nixpkgs: 
let selfPkgs = self; 
    leanSrc = nixpkgs.fetchFromGitHub {
      owner = "leanprover";
      repo = "lean4";
      rev = "52af4e24715ff1ad6618d952b618f35e2c4307f2";
      sha256 = "sha256:1sp0lavr4vh7nqpysq68xrq9i57y6nr5bn4sy5sczpjhz82swmzz";
    };
in {
  myEmacsPackageOverrides = self: super: super.melpaPackages // {
    # inherit (super) pdf-tools;
    inherit (super) vterm;

    macro-slides = super.trivialBuild {
      pname = "macro-slides";
      version = "0.0";
      src = nixpkgs.fetchFromGitHub {
        owner = "positron-solutions";
        repo = "macro-slides";
        rev = "4af6955e2328983a4764141ae3da9b855ea0cd9c";
        hash = "sha256-JGI5qlHo6VnV6x5CMsxgiPURu+OF7wUUaUZhZOIaW7U=";
      };
    };

    aidermacs = super.trivialBuild rec {
      pname = "aidermacs";
      version = "2025-03-16";
      src = nixpkgs.fetchFromGitHub {
        owner = "MatthewZMD";
        repo = "aidermacs";
        rev = "c346e7f22ec7a48837f929e3b8d46226c913f8bb";
        hash = "sha256-a8+nQdu0ZzPetENPevQ7isNZ/+1DPECcX0DdcA1cXoU=";
      };
    };

    nova = super.trivialBuild rec {
      pname = "nova";
      version = "2025-01-18";
      src = nixpkgs.fetchFromGitHub {
        owner = "thisisran";
        repo = "nova";
        rev = "ae847b21870bb3facaea87dcc8acc2ea4e7590c5";
        hash = "sha256-nmC1MVSG8YHabg7SFUeSJQ1k303Z9tsJDd7BF8w35OU=";
      };
      propagatedUserEnvPkgs = with super.melpaPackages; [
        posframe markdown-mode
      ] ++ [super.elpaPackages.vertico-posframe];
      buildInputs = propagatedUserEnvPkgs;
      prePatch = ''
        sed -i 's/;;; Code:/;;; Code:\n\(require '"'"'nova-utils\)\n\(require '"'"'markdown-mode\)/' nova-eldoc.el
      '';
    };

    master-of-ceremonies = super.trivialBuild {
      pname = "master-of-ceremonies";
      version = "0.0";
      src = nixpkgs.fetchFromGitHub {
        owner = "positron-solutions";
        repo = "master-of-ceremonies";
        rev = "a621a1c8f249f94e5e7b300d2a7f6a50ac3d0a8c";
        hash = "sha256-5np1ifL9j66LsCXjRaxJq+ClJ5WNMbEJTWW53MpWl/g=";
      };
    };

    ligature = super.trivialBuild {
      pname = "ligature";
      version = "0.0";
      src = nixpkgs.fetchFromGitHub {
        owner = "mickeynp";
        repo = "ligature.el";
        rev = "d3426509cc5436a12484d91e48abd7b62429b7ef";
        hash = "sha256-baFDkfQLM2MYW2QhMpPnOMSfsLlcp9fO5xfyioZzOqg=";
      };
    };

    org-tidy = super.org-tidy.overrideAttrs (old: {
      # Fix an issue with key bindings being overridden.
      # See: https://github.com/jxq0/org-tidy/issues/11#issuecomment-1950301932
      postPatch = old.postPatch or "" + ''
        sed "s/'local-map/'keymap/" -i org-tidy.el
      '';
    });

    org = self.elpaPackages.org;

    # lean4-mode = super.melpaBuild {
    #   pname = "lean4-mode";
    #   version = "1";
    #   # src = selfPkgs.lean4-mode.src;
    #   src = "${leanSrc}/lean4-mode";
    #   packageRequires = with super.melpaPackages; [ dash f flycheck magit-section lsp-mode s ];
    #   recipe = nixpkgs.writeText "recipe" ''
    #     (lean4-mode :repo "leanprover/lean4" :fetcher github :files ("*.el"))
    #   '';
    #   fileSpecs = [ "*.el" ];
    #     # tail -n +2 lean4-input.el > tmp.el
    #     # mv tmp.el lean4-input.el
    #   prePatch = ''
    #     sed "s/(require 'rx)/(require 'rx)\n(require 'dash)/" -i lean4-syntax.el
    #   '';
    # };
    ultra-scroll = super.trivialBuild rec {
      pname = "ultra-scroll";
      ename = "ultra-scroll";
      version = "2025-01-18";
      src = nixpkgs.fetchFromGitHub {
        owner = "jdtsmith";
        repo = "ultra-scroll";
        rev = "2e3b9997ae1a469e878feaa0af23a23685a0fbed";
        hash = "sha256-9+3T5tXPRuRtENt/Rr0Ss3LZJlTOwpGePbREqofN2j0=";
      };
    };

    # org-roam-ui = super.trivialBuild {
    #   pname = "org-roam-ui";
    #   version = "2021-10-12";
    #   src = nixpkgs.fetchFromGitHub {
    #     owner = "org-roam";
    #     repo = "org-roam-ui";
    #     rev = "50ebd6c39b40b9b22cd34d932fa9aa5cc334ff37";
    #     hash = "sha256-I5NGREiViMXDqmY7/4juvLMUqsmnPuRBzaV6pi85TJQ=";
    #   };
    #   packageRequires = [self.f self.websocket self.org-roam self.simple-httpd];
    #   postFixup = ''
    #     cp -r out $out/share/emacs/site-lisp
    #   '';
    # };

    org-clock-reminder = super.trivialBuild {
      pname = "org-clock-reminder";
      # version = "2021-10-10";
      # src = nixpkgs.fetchFromGitHub {
      #   owner = "inickey";
      #   repo = "org-clock-reminder";
      #   rev = "9f9b88348ffbc6628f2286dcb4c064b520d0a638";
      #   hash = "sha256-CnOLlgAPOCquOr++wrL+LayOq02NKawAHqut15TAobY=";
      # };
      version = "2021-12-14";
      src = nixpkgs.fetchFromGitHub {
        owner = "acowley";
        repo = "org-clock-reminder";
        rev = "2d290f39032b655b79e3421ec17936e6ba35d108";
        hash = "sha256-EJSlTFVn5oI4yjR71Kei0daZJqP+AMYojceXDt/hL9U=";
      };
      packageRequires = [self.org self.alert];
      postFixup = ''
        cp -r icons $out/share/emacs/site-lisp
      '';
    };

    ob-duckdb = super.trivialBuild {
      pname = "ob-duckdb";
      version = "2024-02-04";
      src = nixpkgs.fetchFromGitHub {
        owner = "smurp";
        repo = "ob-duckdb";
        rev = "3fd1123e7552a97d676be8aebd22dfbe8c6cfd0e";
        hash = "sha256-dZWHFNIPeU1vcbIuZLRdEv6uQi6U/OmWYRmps75Ol5k=";
      };
      packageRequires = [ self.org ];
    };

    clip2org = super.trivialBuild {
      pname = "clip2org";
      version = "2021-06-11";
      src = nixpkgs.fetchFromGitHub {
        owner = "acowley";
        repo = "clip2org";
        rev = "e80616a98780f37c7cc87baefd38ad2180f8a98f";
        sha256 = "sha256:1h3fbblhdb0hrrk0cl0j8wcf4x0z0wma971ahl79m9g9394yvfps";
      };
    };

    org-marginalia = super.trivialBuild {
      pname = "org-marginalia";
      version = "2021-08-29";
      src = nixpkgs.fetchFromGitHub {
        owner = "nobiot";
        repo = "org-marginalia";
        rev = "ad93331bf715f6843438d046e97fcd6eac61a4e6";
        hash = "sha256-6DTQlmyH88j99QlhO5nszkCkFu05AjoKHbgkJKhax6k=";
      };
    };

    # ox-reveal = super.ox-reveal.overrideAttrs (old: {
    #   patches = old.patches or [] ++ [
    #     ./emacs-overlay/ox-reveal-4.0.patch
    #   ];
    # });

    # orgPackages = super.orgPackages // {
    #   org-plus-contrib = super.orgPackages.org-plus-contrib.overrideAttrs (old: {
    #     # This is the feature/org-fold-universal-core branch using
    #     # text properties rather than overlays to display hidden text
    #     # in org files.
    #     src = nixpkgs.fetchFromGitHub {
    #       owner = "yantar92";
    #       repo = "org";
    #       rev = "81a803180db886137e8d9da6c270413bb3ffb775";
    #       sha256 = "sha256:1nrxa4qc6wvfvhqw935ggw79f9k4a43w8y6lw95ad4f95096ipz3";
    #     };
    #   });
    # };

    # pdf-tools = super.pdf-tools.overrideAttrs (old: {
    #   patches = old.patches or [] ++ [
    #     # https://github.com/politza/pdf-tools/pull/588
    #     (nixpkgs.fetchpatch {
    #       name = "pdf-tools-undefined-function";
    #       url = "https://patch-diff.githubusercontent.com/raw/politza/pdf-tools/pull/588.patch";
    #       sha256 = "1pr2cjf2f6kbcrhdil3l73lmqmj636h7g4l80gnw5gxg3cwmqkrv";
    #     })
    #   ];
    # });

    treemacs = super.treemacs.overrideAttrs (old: {
      propagatedBuildInputs = old.propagatedBuildInputs or [] ++ [nixpkgs.python3];
    });

    lsp-mode = super.lsp-mode.overrideAttrs (old: {
      patches = old.patches or [] ++ [
        ./lsp-unicode.patch
      ];
      LSP_USE_PLISTS=true;
    });

    god-mode = super.god-mode.overrideAttrs (old: {
      src = nixpkgs.fetchFromGitHub {
        owner = "emacsorphanage";
        repo = "god-mode";
        rev = "be58e6d75ccdea00ae28cd8303e7c5682b865d6f";
        sha256 = "07la740w3wp8fzsrkk21nn4chdnwxvnz9m5g434vvwvjm5mc510q";
      };
    });

    synosaurus = super.synosaurus.overrideAttrs (old: {
      patches = old.patches or [] ++ [
        ./synosaurus-wordnet3.1.patch
      ];
    });

    # magit = super.magit.overrideAttrs (old: {
    #   patches = old.patches or [] ++ [
    #     (nixpkgs.fetchpatch {
    #       name = "no-new-frame-on-commit.patch";
    #       url = "https://github.com/magit/magit/commit/035c24055c0e111187d554a0a214d6f0cbfb4bf1.patch";
    #       sha256 = "17294fmx8psq5zrjnczsdnnvyg5qfjkic55x2fzaf1rbby8wbp2v";
    #       revert = true;
    #     })
    #   ];
    # });

    # This package did not work well for me. With the minor mode
    # enabled, I could not move point within a number!
    number-separator = super.trivialBuild {
      pname = "number-separator";
      version = "0.0.1";
      src = nixpkgs.fetchFromGitHub {
        owner = "legalnonsense";
        repo = "number-separator.el";
        rev = "96a39e3cc58c4b67c5ed91b7d8a4367d2cc49ebb";
        sha256 = "sha256:0f0gvji701cwv7rzys2y7hvczzk21idd6wxdlbzmi6490i9vyb6j";
      };
      postPatch = ''
        sed "s/\((require 'font-lock)\)/\1\n(require 'cl-lib)/" -i number-separator.el
      '';
    };

    deft = super.deft.overrideAttrs (old: {
      patches = old.patches or [] ++ [
        ./deft-org-titles.patch
      ];
      buildInputs = old.buildInputs ++ [self.org-roam];
    });

    # org-roam = super.melpaBuild rec {
    #   pname = "org-roam";
    #   version = "1.1.0";
    #   src = nixpkgs.fetchFromGitHub {
    #     owner = "jethrokuan";
    #     repo = "org-roam";
    #     rev = "v${version}";
    #     sha256 = "18ljww204kf1pbgrrnx7bn6177lw1bs3npywbx2k1b5j35c3j8xv";
    #   };
    #   packageRequires = [ self.f self.dash self.async 
    #                       self.emacsql self.emacsql-sqlite ];
    #   recipe = nixpkgs.writeText "recipe" ''
    #     (org-roam :repo "jethrokuan/org-roam" :fetcher github)
    #   '';
    # };

    # ccls = super.ccls.overrideAttrs (old: {
    #   src = nixpkgs.fetchFromGitHub {
    #     owner = "MaskRay";
    #     repo = "emacs-ccls";
    #     rev = "b8e2f4d9b5bed5b5e8b387ac8e43eff723120b80";
    #     sha256 = "1g0m5xnapfl5wjlylam5696p49qwwkdlngmjv858fabhhk9z0lin";
    #   };
    # });

    lsp-ui = super.lsp-ui.overrideAttrs (_: {
      # patches = [ ./lsp-ui-doc-hide-fix.patch ];
    });

    # cmake-mode = super.melpaPackages.cmake-mode.overrideAttrs (_: {
    #   patchPhase = ''
    #     sed '2s/.*/;; Version: 0.0/' -i Auxiliary/cmake-mode.el
    #   '';
    # });

    apropospriate-theme =
      # Note: \x27 is a single quote character. This is a way of
      # escaping those characters within the sed command string.
      super.melpaPackages.apropospriate-theme.overrideAttrs (_: {
        patchPhase = ''
          sed 's/(base00   (if (eq variant \x27light) "\(#[0-9A-F]*\)" "#424242"))/(base00   (if (eq variant \x27light) "\1" "#212121"))/' -i apropospriate-theme.el
        '';
      });

    emacsql = super.melpaPackages.emacsql.overrideAttrs (_: {
      src = nixpkgs.fetchFromGitHub {
        owner = "magit";
        repo = "emacsql";
        # Roll back to an earlier version as something isn't updated
        # yet in the build regarding sqlite.
        rev = "fb05d0f72729a4b4452a3b1168a9b7b35a851a53";
        hash = "sha256-MaL3t+2MhWOE6eLmt8m4ImpsKeNeUZ4S8zEoQVu51ZY=";
      };
    });

    # doom-modeline =
    #   super.melpaPackages.doom-modeline.overrideAttrs (_: {
    #     patches = [
    #       ./doom-modals-everywhere.patch
    #       # ./doom-god-no-icon.patch
    #     ];
    # });

    # structured-haskell-mode = super.melpaBuild {
    #   pname = "shm";
    #   version = "20170523";
    #   src = ~/src/structured-haskell-mode;
    #   packageRequires = [ super.haskell-mode ];
    #   fileSpecs = [ "elisp/*.el" ];
    #   propagatedUserEnvPkgs = [ nixpkgs.haskellPackages.structured-haskell-mode ];
    #   recipe = nixpkgs.fetchurl {
    #     url = "https://raw.githubusercontent.com/milkypostman/melpa/68a2fddb7e000487f022b3827a7de9808ae73e2a/recipes/shm";
    #     sha256 = "1qmp8cc83dcz25xbyqd4987i0d8ywvh16wq2wfs4km3ia8a2vi3c";
    #     name = "recipe";
    #   };
    #   meta = {
    #     description = "Structured editing Emacs mode for Haskell";
    #     license = nixpkgs.lib.licenses.bsd3;
    #     platforms = nixpkgs.haskellPackages.structured-haskell-mode.meta.platforms;
    #   };
    # };
  };
  myEmacsPackages = epkgs: with epkgs; [
    # proof-general
    pdf-tools
    use-package
    diminish
    recentf-remove-sudo-tramp-prefix
    visual-fill-column
    apropospriate-theme
    projectile
    yasnippet
    dashboard
    page-break-lines
    all-the-icons
    nerd-icons
    impatient-mode
    # esup
    benchmark-init
    direnv
    dired-du
    dired-narrow
    dired-rsync
    diredfl
    dired-git-info
    ace-window
    notmuch
    literate-calc-mode
    expand-region

    # org packages
    # orgPackages.org-plus-contrib
    org
    org-contrib
    org-superstar
    # org-sticky-header
    # org-table-sticky-header
    org-journal
    ox-reveal
    ox-tufte
    ox-gfm
    ob-ipython
    ob-nim
    ob-duckdb
    ob-http
    org-noter
    org-pdftools
    org-noter-pdftools
    outorg
    outshine
    ox-clip
    org-mime
    org-ref
    org-roam
    org-roam-bibtex
    xeft
    emacsql-sqlite-builtin
    org-books
    org-ql
    org-marginalia
    clip2org
    org-clock-reminder
    org-modern
    svg-tag-mode
    org-tidy
    org-sliced-images
    org-bookmark-heading

    deft

    biblio biblio-core
    helm-bibtex
    parsebib
    auctex
    auctex-latexmk

    #
    olivetti
    company
    prescient
    company-prescient
    corfu-prescient
    consult
    consult-flycheck
    consult-projectile
    consult-dir
    consult-notmuch
    consult-org-roam
    marginalia
    embark
    embark-consult

    # helm
    # helm-company
    # helm-swoop
    # helm-dash
    # helm-tramp
    # helm-projectile
    # helm-gtags
    # helm-org-rifle
    # helm-notmuch
    # wgrep-helm

    # imenu-anywhere
    god-mode
    spaceline
    moody
    doom-modeline
    minions
    multiple-cursors
    buffer-move
    flycheck
    flycheck-color-mode-line
    nix-mode
    glsl-mode
    ess

    haskell-mode

    pyvenv
    # hindent
    # dante
  # ] ++ nixpkgs.lib.optionals (builtins.pathExists ~/src/intero) [
  #   # This is a hacky way of not building these from source on
  #   # machines where we do not expect to use them.
  #   # structured-haskell-mode
  #   intero
  # ] ++ [
    lsp-mode
    lsp-ui
    lsp-haskell
    lsp-treemacs
    # lsp-docker
    ccls

    cmake-mode

    clang-format
    mixed-pitch
    magit

    erc-terminal-notifier
    erc-hl-nicks
    ercn
    znc

    twittering-mode
    corral
    avy

    # rust-mode
    rustic
    cargo
    flycheck-rust
    racer

    dhall-mode
    opencl-c-mode
    purescript-mode
    psc-ide
    paredit
    yaml-mode
    plantuml-mode
    # redprl
    osx-dictionary
    graphviz-dot-mode
    nix-buffer
    toml-mode
    markdown-mode
    web-mode
    smartparens
    logview
    ag
    ripgrep
    xterm-color
    highlight-indent-guides
    vterm
    # docker
    dockerfile-mode
    qml-mode
    emojify
    disk-usage
    speed-type
    pomidor
    synosaurus
    restclient
    gif-screencast
    flyspell-correct
    gnuplot

    # lean4-mode
    org-roam-ui
    which-key
    nim-mode

    bazel

    ligature

    cuda-mode
    ledger-mode
    typescript-mode
    zig-mode
    unisonlang-mode

    protobuf-mode

    vertico
    vertico-prescient
    orderless
    corfu
    corfu-prescient
    cape

    package-lint
    editorconfig

    surround
    easy-kill
    kagi
    password-store
    password-store-otp

    org-present
    visual-fill-column
    pikchr-mode

    # casual-calc # transient menus for calc
    # macro-slides
    # master-of-ceremonies
    ultra-scroll

    nova

    gptel
    aidermacs

    (treesit-grammars.with-grammars (p: [
      p.tree-sitter-bash
      p.tree-sitter-bibtex
      p.tree-sitter-c
      p.tree-sitter-c-sharp
      p.tree-sitter-clojure
      p.tree-sitter-cmake
      p.tree-sitter-cpp
      p.tree-sitter-css
      p.tree-sitter-cuda
      p.tree-sitter-dockerfile
      p.tree-sitter-dot
      p.tree-sitter-elisp
      p.tree-sitter-elixir
      p.tree-sitter-glsl
      p.tree-sitter-haskell
      p.tree-sitter-html
      p.tree-sitter-http
      p.tree-sitter-java
      p.tree-sitter-javascript
      p.tree-sitter-jsdoc
      p.tree-sitter-json
      p.tree-sitter-json5
      p.tree-sitter-julia
      p.tree-sitter-latex
      p.tree-sitter-ledger
      p.tree-sitter-llvm
      p.tree-sitter-lua
      p.tree-sitter-make
      p.tree-sitter-markdown
      p.tree-sitter-markdown-inline
      p.tree-sitter-nix
      p.tree-sitter-ocaml
      p.tree-sitter-ocaml-interface
      p.tree-sitter-perl
      p.tree-sitter-php
      p.tree-sitter-python
      p.tree-sitter-r
      p.tree-sitter-regex
      p.tree-sitter-ruby
      p.tree-sitter-rust
      p.tree-sitter-scheme
      p.tree-sitter-scss
      p.tree-sitter-sql
      p.tree-sitter-toml
      p.tree-sitter-typescript
      p.tree-sitter-verilog
      p.tree-sitter-yaml
      p.tree-sitter-zig
      p.tree-sitter-wgsl
    ]))
  ];
  # myemacsPkgs = (self.emacsPackagesFor self.emacs-git).overrideScope' self.myEmacsPackageOverrides;
  # myemacs = ((self.emacsPackagesFor self.emacs-git).overrideScope' self.myEmacsPackageOverrides).emacsWithPackages self.myEmacsPackages;

  # myemacs = self.emacs-pgtk;
  myemacs = self.emacs-unstable;
  # myemacs = self.emacs-unstable.overrideAttrs (old: {
    # patches = old.patches or [] ++ [
    #   # Fix an issue with displaying SVG images that may have a
    #   # viewBox attribute but no width or height set.
    #   # https://lists.gnu.org/archive/html/bug-gnu-emacs/2023-08/msg00533.html
    #   (nixpkgs.fetchpatch {
    #     url = "https://lists.gnu.org/archive/html/bug-gnu-emacs/2023-08/txtiivFeeJiEX.txt";
    #     hash = "sha256-KSVWwLf8Dxb+0B54MbdtTqNHuh7j3jU6bojN3XXeHf4=";
    #   })
    # ];
  # });
  #myemacsGcc = ((self.emacsPackagesFor self.myemacs).overrideScope' self.myEmacsPackageOverrides).emacsWithPackages self.myEmacsPackages;
  #myemacsGccPkgs = (self.emacsPackagesFor self.myemacs).overrideScope' self.myEmacsPackageOverrides;
  myemacsGcc = ((self.emacsPackagesFor self.myemacs).overrideScope self.myEmacsPackageOverrides).emacsWithPackages self.myEmacsPackages;
  myemacsGccPkgs = (self.emacsPackagesFor self.myemacs).overrideScope self.myEmacsPackageOverrides;

  myemacsPgtk = ((self.emacsPackagesFor self.emacs-pgtk).overrideScope self.myEmacsPackageOverrides).emacsWithPackages self.myEmacsPackages;

  myemacsLsp = ((self.emacsPackagesFor self.emacsLsp).overrideScope' self.myEmacsPackageOverrides).emacsWithPackages self.myEmacsPackages;

  emacsGccMac = self.emacsGcc.overrideAttrs (old: {
    configureFlags = old.configureFlags or [] ++ ["--with-mac-metal"];
  });
  myemacsGccMac = ((self.emacsPackagesFor self.emacsGccMac).overrideScope' self.myEmacsPackageOverrides).emacsWithPackages self.myEmacsPackages;
}
