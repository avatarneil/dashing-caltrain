# Dashing-Caltrain
A simple Caltrain widget for Dashing.io

## Installation
* Generate an API key for Caltrain from 511.org
* Clone the repo, and then open a terminal in the root of the repo.
* Add `export CALTRAIN_API_KEY="{Your 511 API Key}"` to your .bashrc, .bash_profile, .zshrc, etc... (This depends on what shell you use)
* Add `export NORTH_BOUND_CODE="{Northbound Stop Code}"` and `export SOUTH_BOUND_CODE="{Southbound Stop Code}"` to your .bashrc, .bash_profile, .zshrc, etc... (This depends on what shell you use). These stop codes (Northbound Stop Code and Southbound Stop Code) can be found by hitting http://api.511.org/transit/StopMonitoring?api_key={Your 511 API Key} &agency=CT, and then searching for the name of your Caltrain stop eg. Millbrae
* `mkdir DASHBOARD_PATH/widgets/caltrain` where DASHBOARD_PATH is the path to your dashboard you wish to install the widget on.
* `cp -a widgets/caltrain DASHBOARD_PATH/widgets/caltrain` 
* `cp -a jobs/caltrain.rb DASHBOARD_PATH/jobs`
* Add the widget to your  by adding this to your dashboard's .erb file by pasting in 
```
<li data-row="1" data-col="1" data-sizex="1" data-sizey="2">
  <div data-id="caltrain" data-view="Caltrain" data-unordered="true" data-title="Caltrain"</div>
</li>
```
* The widget should now be added to your dashboard!
