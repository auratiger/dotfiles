# Deletes all copy branches of the currenly visited branch.
# Example:
#
#   -- git branches --
#
#      master
#    * test
#      test-COPY-0
#      test-COPY-1
#      test-COPY-2
#      test-COPY-3
#
# -- Calling: ". ./dcopyall.sh" --
#
#    Deleted branch test-COPY-0 (was 7eba680).
#    Deleted branch test-COPY-1 (was 7eba680).
#    Deleted branch test-COPY-2 (was 7eba680).
#    Deleted branch test-COPY-3 (was 7eba680).

full_name=$(git branch --show current)

echo $full_name | egrep -o '^[^-COPY]+' | read name

branches=()
eval "$(git for-each-ref --shell --format='branches+=(%(refname:short))' refs/heads/)"

for branch in "${branches[@]}"; do
   re="^${name}-COPY.+$"

   if [[ $branch =~ $re ]]; then
      git branch -D $branch
   fi
done
