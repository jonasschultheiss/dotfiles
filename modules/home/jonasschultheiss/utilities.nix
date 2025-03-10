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

      # Check if trash directory exists
      if not test -d $trash_dir
        echo "Trash directory not found at $trash_dir"
        return 1
      end

      # Try to count items safely with error suppression
      set -l count (command ls -la $trash_dir 2>/dev/null | wc -l | tr -d ' ' || echo "0")

      # If we couldn't get a count, handle it gracefully
      if test "$count" = "0"
        echo "Unable to access trash contents (permission issue)"
        echo "Do you want to attempt to empty the trash anyway? (y/N)"
        read -l confirm
        if test "$confirm" != "y" -a "$confirm" != "Y"
          echo "Operation cancelled."
          return 1
        end
      else
        # Subtract 3 for the ".", "..", and "total" lines
        set -l file_count (math $count - 3)

        if test $file_count -le 0
          echo "Trash is already empty."
          return 0
        end

        echo "Trash contains approximately $file_count items."
      end

      echo "Clearing trash..."
      command rm -rf $trash_dir/* 2>/dev/null

      # Even if we couldn't count items, we can verify if the operation was successful
      set -l remaining (command ls -la $trash_dir 2>/dev/null | wc -l | tr -d ' ' || echo "?")
      if test "$remaining" = "?"
        echo "Attempted to clear trash, but unable to verify results due to permission issues."
      else
        set -l remaining_files (math $remaining - 3)
        if test $remaining_files -le 0
          echo "Trash cleared successfully!"
        else
          echo "Some items could not be removed. $remaining_files items remain."
        end
      end
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
