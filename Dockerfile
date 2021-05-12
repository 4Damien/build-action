FROM  ghcr.io/mesopelagique/4dockerubun:latest
LABEL repository="https://github.com/mesopelagique/build-action"
LABEL homepage="https://github.com/mesopelagique/build-action"

LABEL "com.github.actions.name"="GitHub Action for 4D"
LABEL "com.github.actions.description"="A tool to build with 4D."
LABEL "com.github.actions.icon"="codesandbox"
LABEL "com.github.actions.color"="blue"

COPY entrypoint.sh /opt/4dserver
COPY Project /opt/4dserver/Project
ENTRYPOINT ["/opt/4dserver/entrypoint.sh"]
