#!/bin/sh

cat << EOF > ../config/jiralert.yml
---
# Global defaults, applied to all receivers where not explicitly overridden. Optional.
# Global defaults, applied to all receivers where not explicitly overridden. Optional.
defaults:
  # API access fields.
  api_url: $JIRALERT_URL
  user: $JIRALERT_USER
  password: $JIRALERT_PASS
  # The type of JIRA issue to create. Required.
  issue_type: Story
  # Issue priority. Optional.
  priority: ""
  # Go template invocation for generating the summary. Required.
  summary: '{{ template "jira.summary" . }}'
  # Go template invocation for generating the description. Optional.
  description: '{{ template "jira.description" . }}'
  # State to transition into when reopening a closed issue. Required.
  reopen_state: "SELECTED FOR DEVELOPMENT"
  # Do not reopen issues with this resolution. Optional.
  wont_fix_resolution: "Won't Fix"
  # Amount of time after being closed that an issue should be reopened, after which, a new issue is created.
  # Optional (default: always reopen)
  reopen_duration: 0h

# Receiver definitions. At least one must be defined.
receivers:
  # Must match the Alertmanager receiver name. Required.
  - name: 'jira-ab'
    # JIRA project to create the issue in. Required.
    project: $JIRA_PROJECT
    # Copy all Prometheus labels into separate JIRA labels. Optional (default: false).
    add_group_labels: true

# File containing template definitions. Required.
template: jiralert.tmpl
EOF

/bin/jiralert /config/jiralert.yml /config/jiralert.tmpl
