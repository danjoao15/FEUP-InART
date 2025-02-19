package iart.model;

import java.awt.Component;

import javax.swing.JTable;
import javax.swing.SwingConstants;
import javax.swing.table.DefaultTableCellRenderer;

public class AutorRenderer extends DefaultTableCellRenderer {
	@Override
	public Component getTableCellRendererComponent(final JTable paramTable, final Object paramValue, boolean isSelected, boolean hasFocus, int rowIndex, int columnIndex) {
		super.getTableCellRendererComponent(paramTable, paramValue, isSelected, hasFocus, rowIndex, columnIndex);

		switch (columnIndex) {
			case 0: case 4:
				setHorizontalAlignment(SwingConstants.CENTER);
				break;
			case 1:
				setHorizontalAlignment(SwingConstants.LEFT);
				break;
			default:
				setHorizontalAlignment(SwingConstants.RIGHT);
				break;
		}

		return this;
	}
}