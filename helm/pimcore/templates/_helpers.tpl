{{/*
Expand the name of the chart.
*/}}
{{- define "pimcore.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pimcore.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pimcore.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pimcore.labels" -}}
helm.sh/chart: {{ include "pimcore.chart" . }}
{{ include "pimcore.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pimcore.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pimcore.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pimcore.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pimcore.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "pimcore.initContainers.wait-for-mysql" -}}
- name: wait-for-mysql
  image: divante/mysql-client:1.0.0
  command:
    - sh
    - -c
    - until mysql -u {{ .Values.pimcore.db.username }} -p{{ .Values.pimcore.db.password }} -h {{ .Values.pimcore.db.host }} {{ .Values.pimcore.db.name }} -e "SELECT 1"; do echo wait-for-mysql; sleep 5; done;
{{- end -}}

{{- define "pimcore.initContainers.wait-for-pimcore-installed" -}}
- name: wait-for-pimcore-installed
  image: busybox:latest
  command:
  - "sh"
  - "-c"
  - "until [ -f /var/www/pimcore/var/config/system.yml ]; do echo wait-for-pimcore-installed; sleep 5; done;"
  volumeMounts:
  - name: pimcore-data
    mountPath: /var/www/pimcore/var/config
    subPath: var/config
{{- end -}}
