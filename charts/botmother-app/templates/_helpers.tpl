{{/*
Expand the name of the chart.
*/}}
{{- define "botmother-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "botmother-app.fullname" -}}
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
{{- define "botmother-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "botmother-app.labels" -}}
helm.sh/chart: {{ include "botmother-app.chart" . }}
{{ include "botmother-app.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: botmother
{{- end }}

{{/*
Selector labels
*/}}
{{- define "botmother-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "botmother-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- range $key, $value := .Values.podLabels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}

{{/*
Service port
*/}}
{{- define "botmother-app.servicePort" -}}
{{- .Values.service.port | default 8080 }}
{{- end }}

{{/*
Target port
*/}}
{{- define "botmother-app.targetPort" -}}
{{- .Values.service.targetPort | default (include "botmother-app.servicePort" .) }}
{{- end }}

{{/*
Probe port
*/}}
{{- define "botmother-app.probePort" -}}
{{- include "botmother-app.targetPort" . }}
{{- end }}
