import java.awt.EventQueue;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.plaf.synth.SynthSpinnerUI;
import javax.swing.JTextField;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import javax.swing.JButton;
import javax.swing.ButtonGroup;
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
	private JRadioButton RadioButtonUniform;
	private JRadioButton RadioButtonVariable;
	private JButton FileButton;
	private FileReader fileVariable = null;


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
		comboBox_2.setModel(new DefaultComboBoxModel(new String[] {"16", "32"}));
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
				if(RadioButtonUniform.isSelected())
				{
					modifyVHD(textX.getText()+"x"+textY.getText() , (String) comboBox_1.getSelectedItem() , (String) comboBox_2.getSelectedItem(), (String) ProtectionBox.getSelectedItem());
				}
				else if(RadioButtonVariable.isSelected())
				{
					modifyVHDVariable(textX.getText()+"x"+textY.getText() , (String) comboBox_1.getSelectedItem() , (String) comboBox_2.getSelectedItem());
				}
				JOptionPane.showMessageDialog(rootPane,"NoC generated successfully.");
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
				btnGerarNoc.setEnabled(false);
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
					if (returnVal == JFileChooser.APPROVE_OPTION) 
					{
						fileVariable = new FileReader(chooser.getSelectedFile());
					}
					if(fileVariable == null)
					{
						JOptionPane.showMessageDialog(rootPane,"File not selected.");
					}
					else
					{
						JOptionPane.showMessageDialog(rootPane,"File read successfully.");
						btnGerarNoc.setEnabled(true);
					}
				}catch (FileNotFoundException e1) {
					JOptionPane.showMessageDialog(rootPane,"Unable to open file.");
				}catch(NoSuchElementException w)
				{
					JOptionPane.showMessageDialog(rootPane,"File not found.");
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
	
	
	/*
	 * Still missing features related to flit size different from 16 bits.
	 * Depends on how these extra ECCs are going to be implemented.
	 */
	private void modifyVHDVariable(String topologia, String buffer, String flit)
	{
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
		File source = new File("NoC-Variable");
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

		try{
			File routingTable = new File("NoC-Variable/Thor_Package.vhd");
			BufferedWriter bw = new BufferedWriter(new FileWriter("Results/Thor_package.vhd"));
			Scanner sc = new Scanner(routingTable);
			while(sc.hasNextLine())
			{
				String line = sc.nextLine();
				switch(line.split(":")[0]){
				case "    constant NUM_X ":
					line = line.split(":")[0] + ":" + line.split(":")[1] + ":" + "= " + dimX + ";";
					break;
				case "    constant NUM_Y ":
					line = line.split(":")[0] + ":" + line.split(":")[1] + ":" + "= " + dimY + ";";
					break;
				case "    constant TAM_BUFFER":
					line = line.split(":")[0] + ":" + line.split(":")[1] + ":"  + "= " + buffer + ";";
					break;
				case "    constant TAM_FLIT ":
					line = line.split(":")[0] + ":" + line.split(":")[1] + ":"  + "= " + flit + ";";
					break;
				case "        variable nocInput ":
					line = line.split(":")[0] + ":" + line.split(":")[1] + ":" + line.split(":")[2];
					bw.write(line);
					bw.newLine();

					Scanner sr = new Scanner(fileVariable);
					while (sr.hasNextLine()) {
						String lineVariable = sr.nextLine();
						line = "                    ";
						for(int index = 0; index < lineVariable.split(";").length; index++)
						{
							if(!lineVariable.split(";")[index].equals(null))
							{	
								line = line+"("+lineVariable.split(";")[index]+")";
								if(sr.hasNextLine() || index < lineVariable.split(";").length-1)
								{
									line = line + ",";
								}
							}
						}
						bw.write(line);
						bw.newLine();
					}
					bw.write("            );");
					bw.newLine();
					sr.close();
					line = "";
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
}