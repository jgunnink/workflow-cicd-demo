git checkout master && \
git pull origin master --depth=1 && \
git checkout $COMMIT_SHA

if [ git diff --quiet HEAD~1 $COMMIT_SHA ${_COMPARISON} ]; then
  return "no_change"
else
  return "changes"
fi
