import { registerRootComponent } from 'expo';
import * as Updates from 'expo-updates';

import App from './App';

// registerRootComponent calls AppRegistry.registerComponent('main', () => App);
// It also ensures that whether you load the app in the Expo client or in a native build,
// the environment is set up appropriately
Updates.reloadAsync();
registerRootComponent(App);
