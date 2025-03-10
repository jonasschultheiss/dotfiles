{
  config,
  pkgs,
  lib,
  ...
}: {
  # Add user-specific fish functions
  programs.fish.functions = {
    # Clear trash (user-specific)
    clear-trash = ''
      set -l trash_dir ~/.Trash
      set -l count (ls -la $trash_dir | wc -l | tr -d ' ')

      # Subtract 3 for the ".", "..", and "total" lines
      set -l file_count (math $count - 3)

      if test $file_count -eq 0
        echo "Trash is already empty."
        return 0
      end

      echo "Trash contains $file_count items. Clearing trash..."
      rm -rf $trash_dir/*
      echo "Trash cleared successfully!"
    '';
  };

  # Add user-specific shell aliases
  programs.fish.shellAliases = {
    # Shorter alias for the trash function
    "trash-clear" = "clear-trash";

    # User-specific aliases
    "rebuild" = "cd ~/.config/nixpkgs && build-configs && apply-configs";
  };
}
