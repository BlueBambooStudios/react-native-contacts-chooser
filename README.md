
# react-native-contacts-picker

Native wrapper for iOS and Android contacts picker UIs.

## Getting started

`$ npm install react-native-contacts-picker --save`

### Mostly automatic installation

`$ react-native link react-native-contacts-picker`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-contacts-picker` and add `RNContactsPicker.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNContactsPicker.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<
5. Add ```Privacy - Contacts Usage Description``` to your project's info.plist

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.bluebamboostudios.RNContactsPickerPackage;` to the imports at the top of the file
  - Add `new RNContactsPickerPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-contacts-picker'
  	project(':react-native-contacts-picker').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-contacts-picker/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-contacts-picker')
  	```
4. Add ```<uses-permission android:name="android.permission.READ_CONTACTS" />``` to your Android Manifest

## Usage
```javascript
import RNContactsPicker from 'react-native-contacts-picker';

// TODO: What to do with the module?
try {
	const granted = RNContactsPicker.requestAccess();
} catch (e) {
	console.error(e);
}
```
  