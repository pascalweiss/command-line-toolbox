When releasing a new version of the chart and the image, you need to update the version in the following files:
1. Find out the current chart/image version. Read it from the `Chart.yaml` file.

2. Update image tag in `values.yaml` with z = z+1:
   ```yaml
   image:
     tag: "x.y.z"  # Update this version number
   ```

3. Update version and appVersion in `Chart.yaml` with z = z+1:
   ```yaml
   version: x.y.z  # Chart version - increment when chart changes
   appVersion: "x.y.z"  # Application version - match with image tag
   ```

4. Update TAG variable in `.gitlab-ci.yml` with z = z+1:
   ```yaml
   variables:
     TAG: x.y.z  # Update this version number
   ```