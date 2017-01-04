import java.awt.BorderLayout;
import java.awt.EventQueue;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import java.awt.Label;
import javax.swing.JTextField;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JButton;
import javax.swing.JScrollPane;
import javax.swing.border.LineBorder;
import java.awt.Color;
import javax.swing.JLayeredPane;
import javax.swing.ListSelectionModel;
import javax.swing.AbstractListModel;
import javax.swing.ButtonGroup;
import javax.swing.JRadioButtonMenuItem;
import java.awt.List;
import java.awt.Choice;
import java.awt.ScrollPane;
import javax.swing.JToolBar;
import java.awt.Window.Type;
import javax.swing.DefaultComboBoxModel;
import java.awt.event.ActionListener;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.NoSuchElementException;
import java.util.Scanner;
import java.awt.event.ActionEvent;
import javax.swing.JRadioButton;
import javax.swing.event.ChangeListener;
import javax.swing.event.ChangeEvent;
import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeEvent;
import java.awt.event.ItemListener;
import java.awt.event.ItemEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class venIDE extends JFrame {

	private JPanel contentPane;
	private JTextField txtTopologia;
	private JTextField txtTamanhoDoBuffer;
	private JTextField txtTamanhoDoFlit;
	private JTextField txtProteo;
	private JTextField textX;
	private JTextField textY;
	private JTextField textDummy;
	private JTextField textField;
	private JRadioButton RadioButtonUniform;
	private JRadioButton RadioButtonVariable;
	private JButton FileButton;


	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					venIDE frame = new venIDE();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public venIDE() {
		setTitle("VENInterface");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 401, 314);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);

		txtTopologia = new JTextField();
		txtTopologia.setEditable(false);
		txtTopologia.setText("Topology:");
		txtTopologia.setBounds(10, 11, 116, 20);
		contentPane.add(txtTopologia);
		txtTopologia.setColumns(10);

		txtTamanhoDoBuffer = new JTextField();
		txtTamanhoDoBuffer.setEditable(false);
		txtTamanhoDoBuffer.setText("Buffer Size:");
		txtTamanhoDoBuffer.setBounds(10, 59, 116, 20);
		contentPane.add(txtTamanhoDoBuffer);
		txtTamanhoDoBuffer.setColumns(10);



		txtTamanhoDoFlit = new JTextField();
		txtTamanhoDoFlit.setEditable(false);
		txtTamanhoDoFlit.setText("Flit Size:");
		txtTamanhoDoFlit.setBounds(10, 107, 116, 20);
		contentPane.add(txtTamanhoDoFlit);
		txtTamanhoDoFlit.setColumns(10);

		txtProteo = new JTextField();
		txtProteo.setEditable(false);
		txtProteo.setText("Protection:");
		txtProteo.setBounds(10, 167, 116, 20);
		contentPane.add(txtProteo);
		txtProteo.setColumns(10);

		//BUFFER
		JComboBox comboBox_1 = new JComboBox();
		comboBox_1.setModel(new DefaultComboBoxModel(new String[] {"16", "32"}));
		comboBox_1.setBounds(195, 59, 143, 20);
		contentPane.add(comboBox_1);

		//FLIT
		JComboBox comboBox_2 = new JComboBox();
		comboBox_2.setModel(new DefaultComboBoxModel(new String[] {"16", "32", "64"}));
		comboBox_2.setBounds(195, 107, 143, 20);
		contentPane.add(comboBox_2);

		//DIMENSION X
		textX = new JTextField();
		textX.setBounds(195, 11, 46, 20);
		contentPane.add(textX);
		textX.setColumns(10);

		//DIMENSION Y
		textY = new JTextField();
		textY.setBounds(292, 11, 46, 20);
		contentPane.add(textY);
		textY.setColumns(10);
		
		JComboBox ProtectionBox = new JComboBox();
		ProtectionBox.setModel(new DefaultComboBoxModel(new String[] {"None", "Extended Hamming Protection", "Matrix Protection", "CLC Protection"}));
		ProtectionBox.setBounds(195, 198, 143, 20);
		contentPane.add(ProtectionBox);
		ProtectionBox.setVisible(false);

		JButton btnGerarNoc = new JButton("Create NoC");
		btnGerarNoc.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				//createVHD(textX.getText()+"x"+textY.getText() , (String) comboBox_1.getSelectedItem() , (String) comboBox_2.getSelectedItem());
				if(RadioButtonUniform.isSelected())
				{
					modifyVHD(textX.getText()+"x"+textY.getText() , (String) comboBox_1.getSelectedItem() , (String) comboBox_2.getSelectedItem(), (String) ProtectionBox.getSelectedItem());
				}
				else if(RadioButtonVariable.isSelected())
				{
					
				}
				JOptionPane.showMessageDialog(rootPane,"ThorPackage.vhd Criado com sucesso!!");
			}
		});
		btnGerarNoc.setBounds(132, 241, 109, 23);
		btnGerarNoc.setEnabled(false);
		contentPane.add(btnGerarNoc);


		//DUMMY
		//USED ONLY FOR DESIGN
		textDummy = new JTextField();
		textDummy.setText("X");
		textDummy.setEditable(false);
		textDummy.setBounds(251, 11, 32, 20);
		contentPane.add(textDummy);
		textDummy.setColumns(10);

		JTextField textType = new JTextField();
		textType.setEnabled(true);
		textType.setEditable(false);
		textType.setBounds(10, 198, 116, 20);
		contentPane.add(textType);
		textType.setColumns(10);
		textType.setVisible(false);
		textType.setText("Type:");
		


		RadioButtonUniform = new JRadioButton("Uniform");
		RadioButtonUniform.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				if(RadioButtonUniform.isSelected())
				{
					btnGerarNoc.setEnabled(true);
					FileButton.setVisible(false);
					textType.setVisible(true);
					ProtectionBox.setVisible(true);
				}
			}
		});

		RadioButtonUniform.setBounds(184, 166, 85, 23);
		contentPane.add(RadioButtonUniform);

		RadioButtonVariable = new JRadioButton("Variable");
		RadioButtonVariable.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				btnGerarNoc.setEnabled(true);
				textType.setVisible(false);
				FileButton.setVisible(true);
				ProtectionBox.setVisible(false);
			}
		});

		RadioButtonVariable.setBounds(292, 166, 85, 23);
		contentPane.add(RadioButtonVariable);

		ButtonGroup Options = new ButtonGroup();
		Options.add(RadioButtonUniform);
		Options.add(RadioButtonVariable);

		FileButton = new JButton("Load File");
		FileButton.setVisible(false);
		FileButton.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try{
					JFileChooser chooser = new JFileChooser("Choose a input file");
					int returnVal = chooser.showOpenDialog(rootPane);
					FileReader file = null;
					if (returnVal == JFileChooser.APPROVE_OPTION) 
					{
						file = new FileReader(chooser.getSelectedFile());
						Scanner sc = new Scanner(file);
						while (sc.hasNextLine()) {

							//
							//
							//FALTA SER FEITO
							//
							//

							sc.nextLine();
						}
						sc.close();
					}
					if(file == null)
					{
						JOptionPane.showMessageDialog(rootPane,"File not selected.");
					}
					else
					{
						JOptionPane.showMessageDialog(rootPane,"File read successfully.");
					}
				}catch (FileNotFoundException e1) {
					JOptionPane.showMessageDialog(rootPane,"Unable to open file.");
				}catch(NoSuchElementException w)
				{

				}
			}
		});
		FileButton.setBounds(10, 198, 116, 23);
		contentPane.add(FileButton);
	}
	
	
	private void modifyVHD(String topologia, String buffer, String flit, String type)
	{
		switch(type){
		case "None":
			type = "Nocthor"+flit;
			break;
		case "Extended Hamming Protection":
			type = "NocHamming"+flit;
			break;
		case "Matrix Protection":
			type = "NocMatrix"+flit;
			break;
		case "CLC Protection":
			type = "NocCLC"+flit;
			break;
		}
		
		int dimX = 0;
		int dimY = 0;
		try{
			dimX = Integer.valueOf(topologia.split("x")[0]);
			dimY = Integer.valueOf(topologia.split("x")[1]);
			if(dimX == 0 || dimY == 0)
			{
				JOptionPane.showMessageDialog(rootPane,"Size can't be set to 0. Please input correct numeric values.");
				System.exit(0);
			}
		}catch(NumberFormatException e)
		{
			JOptionPane.showMessageDialog(rootPane,"Non numeric values used for size. Please input correct numeric values.");
			System.exit(0);
		}
		
		File destiny = new File("Results");
		if(!destiny.isDirectory())
		{
			destiny.mkdirs();
		}
		else
		{
			for(String old : destiny.list())
			{
				new File(destiny.getPath(),old).delete();
			}
		}
		File source = new File("NoC-ECC/"+type);
		String files[] = source.list();
		for(String file : files)
		{
			File srcFile = new File(source, file);
            File destFile = new File("Results/", file);
            try {
				Files.copy(srcFile.toPath(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		String filename = "NoC-ECC/"+type+"/Thor_package.vhd";
				
		try{
			File routingTable = new File(filename);
			
			BufferedWriter bw = new BufferedWriter(new FileWriter("Results/Thor_package.vhd"));
			Scanner sc = new Scanner(routingTable);
			while(sc.hasNextLine())
			{
				String line = sc.nextLine();
				switch(line.split(":")[0]){
				case "	constant NUM_X ":
					line = line.split(":")[0] + ":" + line.split(":")[1] + ":" + "= " + dimX + ";";
					break;
				case "	constant NUM_Y ":
					line = line.split(":")[0] + ":" + line.split(":")[1] + ":" + "= " + dimY + ";";
					break;
				case "	constant TAM_BUFFER":
					line = line.split(":")[0] + ":" + line.split(":")[1] + ":"  + "= " + buffer + ";";
					break;
				}
				bw.write(line);
				bw.newLine();
			}
			bw.close();
			sc.close();
		}catch (IOException e) {
			e.printStackTrace();
		}
	}


	/*private void createVHD(String topologia , String buffer , String flit){
		String fileName = "Thor_package.vhd";
		try {
			File routingTable = new File(fileName);
			BufferedWriter bw = new BufferedWriter(new FileWriter(routingTable));
			writeRoutingTable(bw, topologia , buffer , flit);
			bw.flush();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void writeRoutingTable(BufferedWriter bw, String topologia , String buffer , String flit) throws IOException {
		writeRoutingTableHeader(bw);
		writeRoutingTableBody(bw,topologia , buffer ,flit);
		writeRoutingTableTail(bw);
	}

	private void writeRoutingTableHeader(BufferedWriter bw) throws IOException {
		bw.append("library IEEE;\n"
				+"use IEEE.Std_Logic_1164.all;\n"
				+"use IEEE.numeric_std.all;\n \n"
				+"package NoCPackage is\n"
				+"-- Independent Constants ------------------ \n"
				+"    constant NPORT: integer := 5; \n"
				+"    constant EAST  : integer := 0;\n"
				+"    constant WEST  : integer := 1;\n"
				+"    constant NORTH : integer := 2;\n"
				+"    constant SOUTH : integer := 3;\n"
				+"    constant LOCAL : integer := 4;\n"
				);
	}

	private void writeRoutingTableBody(BufferedWriter bw , String topologia , String buffer , String flit) throws IOException {
		int dim_x = Integer.valueOf(topologia.split("x")[0]);
		int dim_y = Integer.valueOf(topologia.split("x")[1]);
		bw.append("-- CONSTANTS RELATED TO THE NETWORK BANDWIDTH ------------------\n "
				+"\n"
				+"    constant TAM_FLIT : integer range 1 to 64 :="+ flit + "; \n"
				+"    constant METADEFLIT : integer range 1 to 32 := (TAM_FLIT/2);\n"
				+"    constant QUARTOFLIT : integer range 1 to 16 := (TAM_FLIT/4);\n"
				+"\n"
				+ " -- CONSTANTS RELATED TO THE DEPTH OF THE QUEUE -------------\n"
				+"\n"
				+"    constant TAM_BUFFER: integer :="+ buffer +"; \n"
				+"    constant TAM_POINTER : integer range 1 to 32 := 5; \n"
				+"\n"
				+"-- CONSTANTS RELATED TO THE NUMBER OF ROUTERS ------------\n"
				+"\n "
				+"    constant NUM_X : integer :=" + dim_x +"; \n"
				+"    constant NUM_Y : integer :=" + dim_y +"; \n"
				+"    constant NROT: integer := NUM_X*NUM_Y; \n"
				+"    constant MIN_X : integer := 0;\n"
				+"    constant MIN_Y : integer := 0; \n"
				+"    constant MAX_X : integer := NUM_X-1;\n"
				+"    constant MAX_Y : integer := NUM_Y-1;\n"
				+"\n"
				+"-- NEW HARDWARE VARIABLES -------------\n"
				+" \n"
				+"    type RouterControl is (invalidRegion, validRegion, faultPort, portError); \n"
				+"\n"
				+"-- SUBTYPES, TYPES AND FUNCTIONS -----------\n"
				+" \n"
				+"    subtype reg3 is std_logic_vector(2 downto 0); \n"
				+"    subtype regNrot is std_logic_vector((NROT-1) downto 0); \n"
				+"    subtype regNport is std_logic_vector((NPORT-1) downto 0); \n"
				+"    subtype regflit is std_logic_vector((TAM_FLIT-1) downto 0); \n"
				+"    subtype regmetadeflit is std_logic_vector((METADEFLIT-1) downto 0); \n"
				+"    subtype regquartoflit is std_logic_vector((QUARTOFLIT-1) downto 0);\n"
				+"\n \n"
				+"    type arrayNport_reg3 is array((NPORT-1) downto 0) of reg3;\n"
				+"    type arrayNport_regflit is array((NPORT-1) downto 0) of regflit;\n"
				+"    type arrayNrot_regflit is array((NROT-1) downto 0) of regflit;\n"
				+"    type arrayNrot_regNport is array((NROT-1) downto 0) of regNport\n"
				+"    type matrixNrot_Nport_regflit is array((NROT-1) downto 0) of arrayNport_regflit;\n"
				+"\n"
				+"-- TB FUNCTIONS --------------\n"
				+"\n"
				+"    function ADDRESS_FROM_INDEX(index : integer) return regflit;\n"
				+"    function X_COORDINATE(address: regflit) return natural;\n "
				+ "   function Y_COORDINATE(address: regflit) return natural;\n"
				+"    function OR_REDUCTION(arrayN : std_logic_vector ) return boolean;\n"
				+"\n"
				+"end NoCPackage;\n"


				);



	}

	private void writeRoutingTableTail(BufferedWriter bw) throws IOException {
		bw.append("\n"
				+ "package body NoCPackage is\n"
				+"\n"
				+"    function ADDRESS_FROM_INDEX(index: integer) return regflit is\n"
				+"        variable addrX, addrY: regmetadeflit;\n"
				+"        variable addr: regflit;\n"
				+"    begin\n"
				+"        addrX := std_logic_vector(to_unsigned(index/NUM_X, METADEFLIT));\n"
				+"        addrY := std_logic_vector(to_unsigned(index mod NUM_Y, METADEFLIT));\n"
				+"        addr := addrX & addrY;\n"
				+"        return addr;\n"
				+"    end ADDRESS_FROM_INDEX;\n"
				+"\n"
				+"    function X_COORDINATE(address: regflit) return natural is\n"
				+"    begin\n"
				+"        return TO_INTEGER(unsigned(address(TAM_FLIT-1 downto METADEFLIT)));\n"
				+"    end X_COORDINATE;\n"
				+"\n"
				+"    function Y_COORDINATE(address: regflit) return natural is\n"
				+"    begin\n"
				+"        return TO_INTEGER(unsigned(address(METADEFLIT-1 downto 0)));\n"
				+"    end Y_COORDINATE;\n"
				+"\n"
				+"     function OR_REDUCTION( arrayN: in std_logic_vector ) return boolean is\n"
				+"    begin\n"
				+"        return unsigned(arrayN) /= 0;\n"
				+"    end OR_REDUCTION;\n"
				+"\n"
				+ "end NocPackage;\n");
	}*/
}