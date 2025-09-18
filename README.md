<div align="center">
  <a href="https://github.com/ionic-team/capacitor-filesystem">
    <img src=".github/assets/logo.png" alt="Logo" width="auto" height="100">
  </a>

<h3 align="center"> @capacitor/haptics</h3>

  <p align="center">
    The Haptics API provides physical feedback to the user through touch or vibration.
  </p>
  <p align="center">
    <a href="https://github.com/ionic-team/capacitor-filesystem/issues/new?labels=bug&template=bug-report.md">🐛 Report Bug</a>
    ·
    <a href="https://github.com/ionic-team/capacitor-filesystem/issues/new?labels=enhancement&template=feature-request.md">   💡 Request Feature</a
  </p>
</div>

# Install

```bash
npm install @capacitor/haptics
npx cap sync
```

## Example

```typescript
import { Haptics, ImpactStyle } from '@capacitor/haptics';

const hapticsImpactMedium = async () => {
  await Haptics.impact({ style: ImpactStyle.Medium });
};

const hapticsImpactLight = async () => {
  await Haptics.impact({ style: ImpactStyle.Light });
};

const hapticsVibrate = async () => {
  await Haptics.vibrate();
};

const hapticsSelectionStart = async () => {
  await Haptics.selectionStart();
};

const hapticsSelectionChanged = async () => {
  await Haptics.selectionChanged();
};

const hapticsSelectionEnd = async () => {
  await Haptics.selectionEnd();
};
```

## API

Check the plugin's API [here](packages/capacitor-plugin/README.md)
