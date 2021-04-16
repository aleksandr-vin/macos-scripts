# macOS Scripts

## Video calls and iMessaging

_Text me and call me when upgrade finishes_:
```
brew upgrade ; echo "done" | imessageme ; facetimeme
```

_Text me last 10 lines of build output and call me when build is done_:
```
(make all 2>&1 | tee build.log | tail -10 | imessageme ; facetimeme) & tail -f build.log
```
