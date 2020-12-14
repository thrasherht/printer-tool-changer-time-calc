### Installation ###
---
Download script to `/usr/local/bin` to make it easily accessible.  
If that directory is not in your PATH, adjust to match one of the directories in your PATH.

```bash
cd /usr/local/bin
sudo wget -O toolchangetimecheck https://raw.githubusercontent.com/thrasherht/printer-tool-changer-time-calc/main/tool_changer_time_estimate.sh
sudo chmod +x toolchangetimecheck
```

### usage ###
---

Issue the command with filename and estimated time from slicer.  
Format for time is (days:hours:minutes). You can leave off days and hours for shorter estimates

The below are valid examples
###### Days hours and minutes
```bash
toolchangetimecheck filename 01:10:10
```

###### Hours and minutes only
```bash
toolchangetimecheck filename 10:10
```

###### Minutes only
```bash
toolchangetimecheck filename 10
```
