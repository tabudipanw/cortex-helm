{{/*
Expand the name of the chart.
*/}}
{{- define "cortex-xdr.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cortex-xdr.fullname" -}}
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
{{- define "cortex-xdr.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cortex-xdr.labels" -}}
helm.sh/chart: {{ include "cortex-xdr.chart" . }}
{{ include "cortex-xdr.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cortex-xdr.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cortex-xdr.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Secret names
*/}}
{{- define "cortex-xdr.dockerPullSecretName" -}}
{{- if not .Values.dockerPullSecret.create }}
{{- .Values.dockerPullSecret.name }}
{{- else }}
{{- include "cortex-xdr.fullname" . }}-docker-pull-secret
{{- end }}
{{- end }}

{{- define "cortex-xdr.deploymentSecretName" -}}
{{- include "cortex-xdr.fullname" . }}-deployment
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cortex-xdr.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cortex-xdr.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
