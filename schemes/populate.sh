#!/usr/bin/env nix-shell
#! nix-shell -p flavours -i bash

flavours list || flavours update schemes || { flavours -v update lists && flavours -v update schemes; }

read -r -d '' template_contents << END
{
  slug = "{{scheme-slug}}";
  name = "{{scheme-name}}";
  author = "{{scheme-author}}";
  colors = {
    base00 = "{{base00-hex}}";
    base01 = "{{base01-hex}}";
    base02 = "{{base02-hex}}";
    base03 = "{{base03-hex}}";
    base04 = "{{base04-hex}}";
    base05 = "{{base05-hex}}";
    base06 = "{{base06-hex}}";
    base07 = "{{base07-hex}}";
    base08 = "{{base08-hex}}";
    base09 = "{{base09-hex}}";
    base0A = "{{base0A-hex}}";
    base0B = "{{base0B-hex}}";
    base0C = "{{base0C-hex}}";
    base0D = "{{base0D-hex}}";
    base0E = "{{base0E-hex}}";
    base0F = "{{base0F-hex}}";
  };
}
END

flavours list -l | while read slug; do
    scheme_path=$(flavours info $slug | head -1 | cut -d '@' -f2)
    flavours build $scheme_path <( echo "$template_contents" ) > $slug.nix
done