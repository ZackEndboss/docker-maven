#!/bin/bash
set -e

latest='jdk-7'

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( */ )
versions=( "${versions[@]%/}" )
url='git://github.com/carlossg/docker-maven'

echo '# maintainer: Carlos Sanchez <carlos@apache.org> (@carlossg)'

for version in "${versions[@]}"; do
	commit="$(git log -1 --format='format:%H' -- "$version")"
	
	mavenVersion="$(grep -m1 'ENV MAVEN_VERSION ' "$version/Dockerfile" | cut -d' ' -f3)"
	jdkVersion="$(awk -F '-|:| ' '$1 == "FROM" && $2 == "java" && $3 == "openjdk" { print $4 }' "$version/Dockerfile")"
	
	versionAliases=()
	while [ "${mavenVersion%[.-]*}" != "$mavenVersion" ]; do
		versionAliases+=( $mavenVersion-jdk-$jdkVersion $mavenVersion-$version )
		if [ "$version" = "$latest" ]; then
			versionAliases+=( $mavenVersion )
		fi
		mavenVersion="${mavenVersion%[.-]*}"
	done
	versionAliases+=( $mavenVersion-jdk-$jdkVersion $mavenVersion-$version )
	if [ "$version" = "$latest" ]; then
		versionAliases+=( $mavenVersion latest )
	fi
	
	echo
	for va in "${versionAliases[@]}"; do
		echo "$va: ${url}@${commit} $version"
	done
	
	for variant in onbuild; do
		commit="$(git log -1 --format='format:%H' -- "$version/$variant")"
		echo
		for va in "${versionAliases[@]}"; do
			if [ "$va" = 'latest' ]; then
				va="$variant"
			else
				va="$va-$variant"
			fi
			echo "$va: ${url}@${commit} $version/$variant"
		done
	done
done
