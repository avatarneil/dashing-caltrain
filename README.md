# Dashing-Caltrain
A simple Caltrain widget for Dashing.io

## Installation
* Generate an API key for Caltrain from 511.org
* Clone the repo, and then open a terminal in the root of the repo.
* Add `export CALTRAIN_API_KEY="{Your 511 Api Key}"` to your .bashrc, .bash_profile, .zshrc, etc... (This depends on what shell you use)
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
