{{/*
Expand the name of the chart.
*/}}
{{- define "directus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "code.name" -}}
{{ include "directus.name" . }}-code
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "directus.fullname" -}}
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

{{- define "code.fullname" -}}
{{ include "directus.fullname" . }}-code
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "directus.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "directus.labels" -}}
helm.sh/chart: {{ include "directus.chart" . }}
{{ include "directus.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "code.labels" -}}
helm.sh/chart: {{ include "directus.chart" . }}
{{ include "code.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "directus.selectorLabels" -}}
app.kubernetes.io/name: {{ include "directus.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "code.selectorLabels" -}}
app.kubernetes.io/name: {{ include "code.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}-code
{{- end }}


{{/*
Resource Name
*/}}
{{- define "directus.serverSecretName" -}}
{{ include "directus.fullname" . }}-server-secret
{{- end }}

{{- define "directus.adminSecretName" -}}
{{ include "directus.fullname" . }}-admin-secret
{{- end }}

{{- define "code.adminSecretName" -}}
{{ include "code.fullname" . }}-admin-secret
{{- end }}

{{- define "directus.pvcName" -}}
{{ include "directus.fullname" . }}-pvc
{{- end }}

{{- define "code.pvcName" -}}
{{ include "code.fullname" . }}-pvc
{{- end }}