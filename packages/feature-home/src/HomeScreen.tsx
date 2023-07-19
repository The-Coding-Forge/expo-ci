import { Paragraph } from '@acme/ui';
import { ComponentProps } from 'react';

type HomeScreenProps = ComponentProps<typeof Paragraph>;

export const HomeScreen = (props: HomeScreenProps) => <Paragraph {...props}>111</Paragraph>;
