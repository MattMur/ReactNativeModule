# react-native-nativo-ads

## Getting started

`$ npm install react-native-nativo-ads --save`

### Mostly automatic installation

`$ react-native link react-native-nativo-ads`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-nativo-ads` and add `NativoAds.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libNativoAds.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import com.reactlibrary.NativoAdsPackage;` to the imports at the top of the file
  - Add `new NativoAdsPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-nativo-ads'
  	project(':react-native-nativo-ads').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-nativo-ads/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-nativo-ads')
  	```


## Usage
```javascript
import NativoAds from 'react-native-nativo-ads';

// TODO: What to do with the module?
NativoAds;
```
