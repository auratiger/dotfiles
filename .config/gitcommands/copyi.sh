# Creates a copy branch of the one previous, and if one copy already exists, it
# increments the index at the back

# Example:
# Calling this function 4 times on a certain branch will result in the following
# output
#
#      master
#    * test
#      test-COPY-0
#      test-COPY-1
#      test-COPY-2
#      test-COPY-3

full_name=$(git branch --show current)
sufix="COPY"
index=0

if [[ "$full_name" == *"$sufix"* ]]; then
   last_char=${full_name:(-1)}
   number_regex='^[0-9]+$'

   if [[ $last_char =~ $number_regex ]]; then
      index=$((last_char + 1))
   fi
fi

echo $full_name | egrep -o '^[^-COPY]+' | read name

git co -b "$name"-"$sufix"-"$index"
