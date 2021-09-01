//
//  SpiderPage.swift
//  SpiderCoolpc
//
//  Created by Angus Yi on 2021/4/25.
//

import SwiftUI

struct SpiderPage: View {
    
    @ObservedObject var gpuDataHandler = GPUDataHandler()
    
    init() {
        gpuDataHandler.getCoolpcGPUDatas()
    }
    
    var body: some View {
        Button("Refresh", action: {
            gpuDataHandler.getCoolpcGPUDatas()
        })
        
        List {
            ScrollView(.horizontal, showsIndicators: true) {
                Section(header: GPUHeaderView()) {
                    ForEach(gpuDataHandler.gpuInfoAry) { gpu in
                        GPUListCell(gpu: gpu)
                            .frame(height: 20, alignment: .center)
                    }
                }
            }
        }
        .environment(\.defaultMinListRowHeight, 20)
        .onAppear {
            gpuDataHandler.getCoolpcGPUDatas()
        }
    }
}

#if DEBUG
struct SpiderPage_Previews: PreviewProvider {
    static var previews: some View {
        SpiderPage()
    }
}
#endif

struct GPUHeaderView: View {
    let gpuInfoStringMaxLength = GpuInfoStringMaxLength.shared
    var body: some View {
        HStack {
            HStack {
                setupHeaderText(str: "廠牌")
                setupFilterButton()
                Divider()
            }.frame(width: CGFloat(gpuInfoStringMaxLength.brand ?? 0) + 10, height: nil, alignment: .center)
            HStack {
                setupHeaderText(str: "型號")
                setupFilterButton()
                Divider()
            }.frame(width: CGFloat(gpuInfoStringMaxLength.model ?? 0) + 10, height: nil, alignment: .center)
            HStack {
                setupHeaderText(str: "MHz")
                setupFilterButton()
                Divider()
            }.frame(width: CGFloat(gpuInfoStringMaxLength.MHz ?? 0) + 10, height: nil, alignment: .center)
            HStack {
                setupHeaderText(str: "長度")
                setupFilterButton()
                Divider()
            }.frame(width: CGFloat(gpuInfoStringMaxLength.length ?? 0) + 10, height: nil, alignment: .center)
            HStack {
                setupHeaderText(str: "保固")
                setupFilterButton()
                Divider()
            }.frame(width: CGFloat(gpuInfoStringMaxLength.warranty ?? 0) + 10, height: nil, alignment: .center)
            HStack {
                setupHeaderText(str: "價錢")
                setupFilterButton()
                Divider()
            }.frame(width: CGFloat(gpuInfoStringMaxLength.price ?? 0) + 10, height: nil, alignment: .center)
            Spacer()
        }
    }
    
    private func setupHeaderText(str: String) -> some View {
        return Text(str)
            .font(.system(size: 17))
            .fontWeight(.semibold)
//              .frame(width: CGFloat(gpuInfoStringMaxLength.brand ?? 0), height: nil, alignment: .center)
            .foregroundColor(.green)
            .background(Color.yellow)
    }
    
    private func setupFilterButton() -> some View {
        return
            Button(action: {
                print("button pressed")
            }, label: {
                Image("down_arrow")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .center)
            })
    }
}

struct GPUListCell: View {
    let gpu: GPUInfo
    let gpuInfoStringMaxLength = GpuInfoStringMaxLength.shared
    var body: some View {
        HStack {
            Group {
                Text(gpu.brand ?? "")
                    .font(.system(size: 15))
                    .frame(width: CGFloat(gpuInfoStringMaxLength.brand ?? 0), height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.model ?? "")
                    .font(.system(size: 15))
                    .frame(width: CGFloat(gpuInfoStringMaxLength.model ?? 0) + 10, height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.MHz ?? "")
                    .font(.system(size: 15))
                    .frame(width: CGFloat(gpuInfoStringMaxLength.MHz ?? 0) + 10, height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.length ?? "")
                    .font(.system(size: 15))
                    .frame(width: CGFloat(gpuInfoStringMaxLength.length ?? 0) + 10, height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.warranty ?? "")
                    .font(.system(size: 15))
                    .frame(width: CGFloat(gpuInfoStringMaxLength.warranty ?? 0) + 10, height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.price ?? "")
                    .font(.system(size: 15))
                    .frame(width: CGFloat(gpuInfoStringMaxLength.price ?? 0) + 10, height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Spacer()
        }
    }
}
