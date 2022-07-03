import { render, screen } from '@testing-library/react';
import { make as App } from './App.bs';

test('renders title', () => {
  render(<App />);
  const linkElement = screen.getByText(/TETRIS/i);
  expect(linkElement).toBeInTheDocument();
});
