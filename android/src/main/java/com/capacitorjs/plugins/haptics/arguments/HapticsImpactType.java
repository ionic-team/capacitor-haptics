package com.capacitorjs.plugins.haptics.arguments;

public enum HapticsImpactType implements HapticsVibrationType {
    LIGHT("LIGHT", new long[] { 0, 50 }, new int[] { 0, 110 }),
    MEDIUM("MEDIUM", new long[] { 0, 43 }, new int[] { 0, 180 }),
    HEAVY("HEAVY", new long[] { 0, 60 }, new int[] { 0, 255 });

    private final String type;
    private final long[] timings;
    private final int[] amplitudes;

    HapticsImpactType(String type, long[] timings, int[] amplitudes) {
        this.type = type;
        this.timings = timings;
        this.amplitudes = amplitudes;
    }

    public static HapticsImpactType fromString(String style) {
        for (HapticsImpactType nt : values()) {
            if (nt.type.equals(style)) {
                return nt;
            }
        }
        return HEAVY;
    }

    @Override
    public long[] getTimings() {
        return timings;
    }

    @Override
    public int[] getAmplitudes() {
        return amplitudes;
    }
}
