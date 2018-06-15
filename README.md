
# [React Native Contacts Chooser](https://github.com/BlueBambooStudios/react-native-contacts-chooser) &middot; [![npm version](https://badge.fury.io/js/react-native-contacts-chooser.svg)](https://badge.fury.io/js/react-native-contacts-chooser) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/BlueBambooStudios/react-native-contacts-chooser/pulls)

Native wrapper for iOS and Android contacts picker UIs.

## Getting started

`$ npm install react-native-contacts-chooser --save`

### Mostly automatic installation

`$ react-native link react-native-contacts-chooser`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-contacts-chooser` and add `RNContactsPicker.xcodeproj`
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
import ContactsPicker from 'react-native-contacts-chooser';

try {
	const granted = ContactsPicker.requestAccess();
	if (granted) {
		const contact = ContactsPciker.pickContact();
		alert(JSON.stringify(contact));
	}
} catch (e) {
	console.warn(e);
}
```

## Methods

### Request access (iOS)
```javascript
import ContactsPicker from 'react-native-contacts-chooser';

try {
	const granted = ContactsPicker.requestAccess();
} catch (e) {
	console.error(e);
}
```

### Check access (iOS)
```javascript
import ContactsPicker from 'react-native-contacts-chooser';

try {
	const granted = ContactsPicker.checkAccess();
} catch (e) {
	console.error(e);
}
```

### Get contact
```javascript
import ContactsPicker from 'react-native-contacts-chooser';

try {
	const contact = ContactsPicker.pickContact();
} catch (e) {
	console.error(e);
}
```

### Get multiple contacts
```javascript
import ContactsPicker from 'react-native-contacts-chooser';

try {
	const contacts = ContactsPicker.pickContacts();
} catch (e) {
	console.error(e);
}
```

### Get contact properties
```javascript
import ContactsPicker from 'react-native-contacts-chooser';

try {
	const contact = ContactsPicker.pickProperty();
} catch (e) {
	console.error(e);
}
```
  
## TODO

- [ ] Android support
- [x] Allow picking properties
- [x] Allow multi select
- [ ] Tests!
- [ ] Better documentation

## Known Issues

on iOS there is a bug with picking multiple properties that causes the picker UI to present as the mutliple contact picker and therefore fails to return multiple properties.