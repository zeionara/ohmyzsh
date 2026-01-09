#!/usr/bin/zsh

backward-delete-path-component() {
  local cursor_position=$CURSOR

  if [[ "$BUFFER" == */* ]]; then
    local prefix=${BUFFER[1,cursor_position]}

    if [[ "${prefix[-1]}" == "/" ]]; then
      prefix="$(echo "$prefix" | sed -E 's#(/|[ \t]*)[^/ \t]*/$#\1#')"
    else
      prefix="$(echo "$prefix" | sed -E 's#(/|[ \t]*)[^/ \t]*$#\1#')"
    fi

    local suffix=${BUFFER[cursor_position+1,-1]}

    BUFFER="$prefix$suffix"
    CURSOR=${#prefix}
  else
    # Exhibit the default Ctrl+W behavior (delete the last word)
    zle backward-kill-word
  fi
}

zle -N backward-delete-path-component # delete last path component on ctrl + W

function _smart-dir-accept() {
    # First, try to complete normally
    zle expand-or-complete

    # If we completed to a directory, add slash and continue
    local completed="${(Q)~LBUFFER}${(Q)~RBUFFER}"
    if [[ -d "$completed" && "$completed" != */ ]]; then
        LBUFFER+='/'
        # Now trigger menu completion for files inside
        zle menu-complete
    fi
}

zle -N _smart-dir-accept

# function _go-up-one-dir() {
#     # echo "\n=== DEBUG ==="
#     local -a words
#     words=(${(z)BUFFER})
#     local last_word="${(Q)words[-1]}"
#     
#     # echo "Original: '$last_word'"
#     
#     if [[ "$last_word" == */* ]]; then
#         # Step 1: Remove trailing slash if present
#         if [[ "$last_word" == */ ]]; then
#             last_word="${last_word%/}"
#             # echo "After removing trailing slash: '$last_word'"
#         fi
#         
#         # Step 2: Remove last path component
#         local parent="${last_word%/*}"
#         # echo "After removing last component: '$parent'"
#         
#         # Step 3: Handle special cases
#         if [[ -z "$parent" ]]; then
#             # Was something like "lib" -> becomes empty
#             parent="."
#         elif [[ "$parent" == "$last_word" ]]; then
#             # No change, e.g., "/usr" -> "/"
#             parent="/"
#         fi
#         
#         # Step 4: Add trailing slash for directory
#         # echo "Final result: '${parent}/'"
#         
#         # Update buffer
#         words[-1]="${(q)parent}/"
#         BUFFER="${(j. .)words}"
#         CURSOR=${#BUFFER}
# 	
#         # zle menu-complete
#     else
#         zle expand-or-complete
#     fi
#     # echo "=== END DEBUG ===\n"
# }

function _go-up-one-dir() {
    # echo "\n=== DEBUG: go-up-one-dir ==="
    local -a words
    words=(${(z)BUFFER})
    local last_word="${(Q)words[-1]}"

    # echo "Last word: '$last_word'"

    if [[ "$last_word" == */* ]]; then
        # echo "Has slash, processing..."
        [[ "$last_word" == */ ]] && last_word="${last_word%/}"
        # echo "After removing trailing slash: '$last_word'"

        local parent="${last_word%/*}"
        # echo "Parent after %/*: '$parent'"

        if [[ -z "$parent" ]]; then
            # echo "Case 1: Empty parent"
            unset 'words[-1]'
            # echo "Removing argument"
        elif [[ "$parent" == "$last_word" ]]; then
            # echo "Case 2: Parent equals original"
            if [[ "$parent" == "/" ]]; then
                # echo "At root, removing argument"
                unset 'words[-1]'
            else
                # echo "Single component, removing argument"
                unset 'words[-1]'
            fi
        else
            # echo "Case 3: Normal case, parent: '$parent/'"
            words[-1]="${(q)parent}/"
        fi

        BUFFER="${(j. .)words}"
        CURSOR=${#BUFFER}
        # echo "New buffer: '$BUFFER'"
    else
        # echo "No slash, doing nothing"
    fi
    # echo "=== END DEBUG ===\n"
}

zle -N _go-up-one-dir
